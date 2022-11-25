import 'dart:convert';
import 'dart:io';
import 'package:findjob_app/models/job_solicitud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:findjob_app/models/models.dart';

class JobsService extends ChangeNotifier {
  final String _baseUrl = 'findjob-410cf-default-rtdb.firebaseio.com';
  final storage = const FlutterSecureStorage();
  final List<Job> jobs = [];
  final List<Job> myJobs = [];

  final List<JobSolicitud> solicitudes = [];//Del lado del usuario(Aspirante)
  final List<JobSolicitud> aspirantes = [];//Del lado del empleador

  final List<Job> myJobsSolicitados = [];//Del usuario (Aspirante)

  late Job selectedJob;
  File? newPictureFile;
  bool isLoading = true;
  bool isSaving = false;

  JobsService() {
    loadJobs();
  }

  Future<List<Job>> loadJobs() async {
    jobs.clear();

    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'jobs.json');
    final resp = await http.get(url);
    final Map<String, dynamic> jobsMap = json.decode(resp.body);

    jobsMap.forEach((key, value) {
      final tempJob = Job.fromMap(value);
      tempJob.id = key;
      jobs.add(tempJob);
    });

        print("Cargaremos las solicitudes hechas");


    if(jobs.length>=0){
        print("Cargaremos las solicitudes hechas");
        loadSolicitudes();
    }

    isLoading = false;
    notifyListeners();
    return jobs;
  }

  Future<List<Job>> loadMyJobs() async {
    /**Este método se encarga de obtener los empleos que el usuario haya ofertado */
    myJobs.clear();
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'jobs.json');
    final resp = await http.get(url);
    final Map<String, dynamic> jobsMap = json.decode(resp.body);

    //Obtenemos el ID del usuario logueado
    var idAutor=await storage.read(key: "user_id") ?? '';

    jobsMap.forEach((key, value) {
      final tempJob = Job.fromMap(value);
      if(tempJob.authorId==idAutor){
        tempJob.id = key;
        myJobs.add(tempJob);
      }
    });
    isLoading = false;
    notifyListeners();
    return myJobs;
  }

  Future saveOrCreateJob(Job job) async {
    isSaving = true;
    notifyListeners();
    if (job.id == null) {
      await createJob(job);
    } else {
      await updateProduct(job);
    }
    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Job job) async {
    final url = Uri.https(_baseUrl, 'jobs/${job.id}.json');
    final resp = await http.put(url, body: job.toJson());
    final decodeData = resp.body;

    //Actualizamos el arreglo trabajos totales
    final index = jobs.indexWhere((element) => element.id == job.id);
    jobs[index] = job;

    //Actualizamos el arreglo de mis trabajos publicados
    if(myJobs.length>=0){
        final index = myJobs.indexWhere((element) => element.id == job.id);
        if(index!=-1){
          //Significa que esa oferta existe en mis trabajos
          myJobs[index] = job;
        }
    }

    return job.id!;
  }

  Future<String> createJob(Job job) async {
    job.author = await storage.read(key: "user_name") ?? '';
    job.authorId = await storage.read(key: "user_id") ?? '';
    job.publishedAt = DateTime.now().toString();

    final url = Uri.https(_baseUrl, 'jobs.json');
    final resp = await http.post(url, body: job.toJson());
    final decodeData = json.decode(resp.body);

    job.id = decodeData['name'];

    jobs.add(job);
    /*Agregamos la nueva oferta en el arreglo de 
    mis ofertas del usuario logueado*/
    myJobs.add(job);

    return job.id!;
  }

  void updateSelectedProductImage(String path) {
    selectedJob.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        "https://api.cloudinary.com/v1_1/dpjcpceqb/image/upload?upload_preset=ofsmrn7w");
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print("Algo salio mal");
      print(resp.body);
      return null;
    }

    final decodeData = json.decode(resp.body);
    return decodeData['secure_url'];
  }


  //Solicitude de postulación
  Future<String> postularseJob(Job job) async {
    
    //Id del usuario logueado
    var idUserLogueado=await storage.read(key: "user_id") ?? '';
    var idEmpleo=job.id;
    var idEmpleador=job.authorId;
    var nombreEmpleador=job.author;
    JobSolicitud jobSolicitud;
    //Mostramos los datos del trabajo seleccionado

    jobSolicitud=new JobSolicitud(idSolicitante: idUserLogueado, idEmpleo: idEmpleo, idEmpleador: idEmpleador, nombreEmpleador: nombreEmpleador, solicitadoAt: DateTime.now().toString());

    final url = Uri.https(_baseUrl, 'postulaciones/${idUserLogueado}.json');
    final resp = await http.post(url, body: jobSolicitud.toJson());
    final decodeData = json.decode(resp.body);

    jobSolicitud.id = decodeData['name'];

    solicitudes.add(jobSolicitud);

    //Si un usuario se postula actualizamos su lista de postulaciones
    cargarMisPostulaciones();
    return jobSolicitud.id!;
  }

  Future<String> agregarAspiranteJob(Job job) async {
    
    //Id del usuario logueado (aspirante)
    var idUserLogueado=await storage.read(key: "user_id") ?? '';
    var idEmpleo=job.id;
    var idEmpleador=job.authorId;
    var nombreEmpleador=job.author;
    JobSolicitud jobSolicitud;
    //Mostramos los datos del trabajo seleccionado

    jobSolicitud=new JobSolicitud(idSolicitante: idUserLogueado, idEmpleo: idEmpleo, idEmpleador: idEmpleador, nombreEmpleador: nombreEmpleador, solicitadoAt: DateTime.now().toString());

    final url = Uri.https(_baseUrl, 'solicitudes/${idEmpleo}.json');
    final resp = await http.post(url, body: jobSolicitud.toJson());
    final decodeData = json.decode(resp.body);

    jobSolicitud.id = decodeData['name'];

    return jobSolicitud.id!;
  }

  Future<List<JobSolicitud>> loadSolicitudes() async {
    /**Este método se encarga de verificar si el usuario 
     * ha enviado alguna solicitud de postulación hacia alguna oferta laboral */

    solicitudes.clear();
    isLoading = true;
    notifyListeners();
    
    var idUserLogueado=await storage.read(key: "user_id") ?? '';
    final url = Uri.https(_baseUrl, 'postulaciones/${idUserLogueado}.json');
    final resp = await http.get(url);
    final Map<String, dynamic> jobsMap = json.decode(resp.body);

    jobsMap.forEach((key, value) {
      final tempJobSolicitud = JobSolicitud.fromMap(value);
      tempJobSolicitud.id = key;
      solicitudes.add(tempJobSolicitud);
    });
    isLoading = false;
    notifyListeners();

    if(solicitudes.length>=0){
      print("Hay postulaciones disponibles");
        //Significa que hay postulaciones
        cargarMisPostulaciones();
    }else{
      print("No Hay postulaciones disponibles");
    }

    return solicitudes;
  }

  Future<List<Job>> cargarMisPostulaciones() async{
    /**Este método se encarga de obtener todas las solicitudes labores que
     * el usuario haya enviado
     */

    myJobsSolicitados.clear();
    isLoading = true;
    notifyListeners();
    solicitudes.forEach((value) {
        final index = jobs.indexWhere((element) => element.id == value.idEmpleo);
        myJobsSolicitados.add(jobs.elementAt(index));
    });
    isLoading = false;
    notifyListeners();

    return myJobsSolicitados;
  }
}
