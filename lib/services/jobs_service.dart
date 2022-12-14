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

  final List<JobSolicitud> solicitudes = []; //Del lado del usuario(Aspirante)
  final List<JobSolicitud> aspirantes = []; //Del lado del empleador

  final List<Job> myJobsSolicitados = []; //Del usuario (Aspirante)

  late JobSolicitud selectedJobSolicitud;
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
    await http.get(url).then((value){
      
      final Map<String, dynamic> jobsMap = json.decode(value.body);
      jobsMap.forEach((key, value) {
        final tempJob = Job.fromMap(value);
        tempJob.id = key;
        jobs.add(tempJob);
      });
      print("Cargaremos las solicitudes hechas");
      if (jobs.length >= 0) {
        print("Cargaremos las solicitudes hechas");
        loadSolicitudes();
        loadMyJobs();
      } 
      
    }).catchError((onError){
      print("No se han encontrado elementos");
  
    });

    isLoading = false;
    notifyListeners();
    return jobs;
  }

  Future<List<Job>> loadMyJobs() async {
    /**Este método se encarga de obtener los empleos que el usuario haya ofertado */
    print("Cargando los empleos");
    myJobs.clear();
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'jobs.json');
    final resp = await http.get(url);
    final Map<String, dynamic> jobsMap = json.decode(resp.body);

    //Obtenemos el ID del usuario logueado
    var idAutor = await storage.read(key: "user_id") ?? '';

    jobsMap.forEach((key, value) {
      final tempJob = Job.fromMap(value);
      if (tempJob.authorId == idAutor) {
        tempJob.id = key;
        myJobs.add(tempJob);
      }
    });
    print("salio");
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
    if (myJobs.length >= 0) {
      final index = myJobs.indexWhere((element) => element.id == job.id);
      if (index != -1) {
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

  Future<bool> postularseJob(Job job, String user_telefono) async {
    //Id del usuario logueado
    var nombreSolicitante = await storage.read(key: "user_name") ?? '';
    var idUserLogueado = await storage.read(key: "user_id") ?? '';
    var idEmpleo = job.id;
    var idEmpleador = job.authorId;
    var nombreEmpleador = job.author;
    JobSolicitud jobSolicitud;

    //Mostramos los datos del trabajo seleccionado

    jobSolicitud = new JobSolicitud(
        idSolicitante: idUserLogueado,
        nombreSolicitante: nombreSolicitante,
        idEmpleo: idEmpleo,
        idEmpleador: idEmpleador,
        nombreEmpleador: nombreEmpleador,
        solicitadoAt: DateTime.now().toString(),
        telefono: user_telefono,
      );

    try {
      final url = Uri.https(_baseUrl, 'postulaciones/${idUserLogueado}.json');
      final resp = await http.post(url, body: jobSolicitud.toJson());
      final decodeData = json.decode(resp.body);
      jobSolicitud.id = decodeData['name'];
      solicitudes.add(jobSolicitud);

      //Si un usuario se postula actualizamos su lista de postulaciones
      //cargarMisPostulaciones();
      final index =
          jobs.indexWhere((element) => element.id == jobSolicitud.idEmpleo);
      myJobsSolicitados.add(jobs.elementAt(index));
      print("Postulación exitosa");
      return true;
    } catch (e) {
      print("Ha ocurrido un error");
      return false;
    }
  }

  Future<String> agregarAspiranteJob(Job job, String user_telefono) async {
    //Id del usuario logueado (aspirante)
    var nombreSolicitante = await storage.read(key: "user_name") ?? '';
    var idUserLogueado = await storage.read(key: "user_id") ?? '';
    var idEmpleo = job.id;
    var idEmpleador = job.authorId;
    var nombreEmpleador = job.author;
    JobSolicitud jobSolicitud;
    //Mostramos los datos del trabajo seleccionado

    jobSolicitud = new JobSolicitud(
        idSolicitante: idUserLogueado,
        nombreSolicitante: nombreSolicitante,
        idEmpleo: idEmpleo,
        idEmpleador: idEmpleador,
        nombreEmpleador: nombreEmpleador,
        solicitadoAt: DateTime.now().toString(),
        telefono: user_telefono,
      );

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
    myJobsSolicitados.clear();

    var idUserLogueado = await storage.read(key: "user_id") ?? '';
    final url = Uri.https(_baseUrl, 'postulaciones/${idUserLogueado}.json');
    final resp = await http.get(url);

    try {
      final Map<String, dynamic> jobsMap = json.decode(resp.body) ?? {};

      jobsMap.forEach((key, value) {
        final tempJobSolicitud = JobSolicitud.fromMap(value);
        tempJobSolicitud.id = key;
        solicitudes.add(tempJobSolicitud);
      });
    } catch (e) {
      print("Ha ocurrido un error en las solicitudes: $e");
    }
    isLoading = false;
    notifyListeners();

    if (solicitudes.length > 0) {
      print("Hay postulaciones disponibles");
      //Significa que hay postulaciones
      cargarMisPostulaciones();
    } else {
      print("No Hay postulaciones disponibles");
    }

    return solicitudes;
  }

  Future<List<Job>> cargarMisPostulaciones() async {
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

  //Sección donde obtendremos los datos de los aspirantes
  //Esto de acuerdo al empleo del que se desee conocer dichos datos

  Future<bool> loadPostulantes(var idEmpleo) async {
    /**Este método se encarga de verificar si el empleo 
     * cuenta con postulantes en espera de una respuesta */

    aspirantes.clear();
    isLoading = true;
    notifyListeners();

    var idUserLogueado = await storage.read(key: "user_id") ?? '';
    final url = Uri.https(_baseUrl, 'solicitudes/${idEmpleo}.json');
    final resp = await http.get(url);

    try {
      final Map<String, dynamic> jobsMap = json.decode(resp.body);
      print("jobsMap ${jobsMap}");
      print(jobsMap.length);
      jobsMap.forEach((key, value) {
        final tempJobSolicitud = JobSolicitud.fromMap(value);
        tempJobSolicitud.id = key;
        aspirantes.add(tempJobSolicitud);
      });
      print("Se han encontrado postulantes");
    } catch (e) {
      print("Error $e");
      print("No se han encontrado postulantes");
    }
    isLoading = false;
    notifyListeners();

    return aspirantes.length == 0 ? false : true;
  }

  /*Proceso de eliminacion de las colecciones de trabajo
  Estos métodos los usa el empleador para eliminar los datos de la oferta laboral
  se implementa desde la interfaz de empleados/mis ofertas
  */

  Future<void> eliminarJobs(var idEmpleo) async {
    /**Este método se encarga de verificar si el empleo 
     * cuenta con postulantes en espera de una respuesta */
    aspirantes.clear();

    isLoading = true;
    notifyListeners();

    var idUserLogueado = await storage.read(key: "user_id") ?? '';
    final url = Uri.https(_baseUrl, 'jobs/${idEmpleo}.json');
    return http.delete(url).then((response) {
      print(response.statusCode);
      print(response.body);

      if (response.statusCode >= 400) {
        throw HttpException("Ha ocurrido un error durante la eliminación");
      } else {
        print("Elemento eliminado exitosamente de la seccion de jobs");

        //Eliminamos el elemento de mis arreglos
        jobs.removeAt(jobs.indexWhere((element) => element.id == idEmpleo));
        myJobs.removeAt(myJobs.indexWhere((element) => element.id == idEmpleo));
        //Si el elemento se elimina procedemos a eliminarlo de las demas colecciones
        eliminarSolicitudes(idEmpleo);
        eliminarPostulaciones(idEmpleo);
        //Si el elemento se borra procedemos a eliminarlo de las solicitudes
      }

      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      notifyListeners();
      print(
          "Ha ocurrido un error durante la eliminación de la oferta laboral \nError: $onError");
    });
  }

  Future<void> eliminarSolicitudes(var idEmpleo) async {
    /**Este método se encarga de verificar si el empleo 
     * cuenta con postulantes en espera de una respuesta */
    notifyListeners();
    var idUserLogueado = await storage.read(key: "user_id") ?? '';
    final url = Uri.https(_baseUrl, 'solicitudes/${idEmpleo}.json');
    return await http.delete(url).then((response) {
      print(response.statusCode);
      print(response.body);
      if (response.statusCode >= 400) {
        throw HttpException("Ha ocurrido un error durante la eliminación");
      } else {
        print("Elemento eliminado exitosamente de la seccion de solicitudes");
        //Si el elemento se borra procedemos a eliminarlo de las solicitudes
      }
      notifyListeners();
    });
  }

  Future<void> eliminarPostulaciones(var idEmpleo) async {
    /**Este método se encarga de verificar si el empleo 
     * cuenta con postulantes en espera de una respuesta */
    notifyListeners();
    final url = Uri.https(_baseUrl, 'postulaciones.json');

    try {
      final resp = await http.get(url);
      final Map<String, dynamic> jobsMap = json.decode(resp.body);
      var idSolicitante;

      jobsMap.forEach((key, value) {
        idSolicitante = key;
        //Recorremos el nodo hijo
        value.forEach((key_, value) {
          final tempJob = JobSolicitud.fromMap(value);
          tempJob.id = key; //Este key corresponde al de la postulacion
          if (tempJob.idEmpleo == idEmpleo) {
            //Procedemos a la eliminación de dicha solicitud
            final urlDos =
                Uri.https(_baseUrl, 'postulaciones/$idSolicitante/$key_.json');

            http.delete(urlDos).then((response) {
              print(response.statusCode);
              print(response.body);
              if (response.statusCode >= 400) {
                throw HttpException(
                    "Ha ocurrido un error durante la eliminación de postulantes");
              } else {
                print(
                    "Elemento eliminado exitosamente de la seccion de postulantes");
                //Si el elemento se borra procedemos a eliminarlo de las solicitudes
              }
            });
          }
        });
      });
    } catch (e) {
      print("Ha ocurrido un error en postulaciones");
      return;
    }

    notifyListeners();
  }

  //Métodos implementados para la cancelación de la postulación
  //Dichos métodos solo se usan desde la interfaz de empleos/solicitudes
  Future<void> eliminarPostulacionesAspirante(var idEmpleo_,var idAspirante_) async {

    var idUser="";
    if(idAspirante_==""){
      idUser = await storage.read(key: "user_id") ?? '';
    }else{
      idUser = idAspirante_;
    }

    final url = Uri.https(_baseUrl, 'postulaciones/$idUser.json');
    var idPostulacion;

    try {
      final resp = await http.get(url);
      final Map<String, dynamic> jobsMap = json.decode(resp.body);

      jobsMap.forEach((key, value) {
        final tempJob = JobSolicitud.fromMap(value);
        tempJob.id = key;

        if (tempJob.idEmpleo == idEmpleo_) {
          print("Elemento encontrao");

          final urlDos = Uri.https(_baseUrl, 'postulaciones/$idUser/$key.json');
          http.delete(urlDos).then((response) {
            print(response.statusCode);
            print(response.body);
            if (response.statusCode >= 400) {
              throw HttpException(
                  "Ha ocurrido un error durante la eliminación de postulantes");
            } else {
              print(
                  "Elemento eliminado exitosamente de la seccion de postulantes aspirante");
              return;
              //Si el elemento se borra procedemos a eliminarlo de las solicitudes
            }
          });
        }
      });
    } catch (e) {
      print(
          "Ha ocurrido un error inesperado en la eliminación de postulaciones dos: $e");
    }
  }

  Future<void> eliminarSolicitudesAspirante(var idEmpleo, var idAspirante) async {

    print("Estamos en la función de eliminación: $idAspirante");

    isLoading = true;
    notifyListeners();
    
    var idUser="";
    if(idAspirante==""){
      //En caso de que se rechace al aspirante
      idUser = await storage.read(key: "user_id") ?? '';
    }else{
      //En caso de que el aspirante cancele la solicitud
      idUser = idAspirante;
    }

    final url = Uri.https(_baseUrl, 'solicitudes/$idEmpleo.json');
    JobSolicitud aux;
    try {
      final resp = await http.get(url);
      final Map<String, dynamic> jobsMap = json.decode(resp.body);

      jobsMap.forEach((key, value) {
        final tempJob = JobSolicitud.fromMap(value);
        tempJob.id = key;
        if(tempJob.idSolicitante==idUser){
          aux=tempJob;

          //Hacemos la eliminación
          final url_ = Uri.https(_baseUrl, 'solicitudes/$idEmpleo/${tempJob.id}.json');
          print("tempoJO ${tempJob.id}");
          http.delete(url_).then((response) {
            print(response.statusCode);
            print(response.body);
            if (response.statusCode >= 400) {
              throw HttpException(
                "Ha ocurrido un error durante la eliminación de solicitudes");
            } else {

            if(idAspirante==""){
              solicitudes.removeAt(solicitudes
                .indexWhere((element) => element.idEmpleo == idEmpleo));
              myJobsSolicitados.removeAt(myJobsSolicitados
                .indexWhere((element) => element.id == idEmpleo));
            }else{
              /*Cancelamos la solicitud del aspirante  
              Borramos el elmento del aspirante*/
              aspirantes.removeAt(aspirantes.indexWhere((element) => element.idSolicitante == idAspirante));          
              //notifyListeners();
            }
          
            //Eliminamos el elemento de aspirantes postulados
            eliminarPostulacionesAspirante(idEmpleo,idAspirante );

            //Eliminamos la solicitud de nuestro arreglo
            print(
              "Elemento eliminado exitosamente de la seccion de solicitudes desde aspirantes");
              isLoading = false;
              notifyListeners();
              }
            });
          }
      });
      
    } catch (e) {
      print("Error en la sección de postulaciones");
      isLoading = false;
      notifyListeners();
    }
  }
}
