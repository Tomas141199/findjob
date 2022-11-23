import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:findjob_app/models/models.dart';

class JobsService extends ChangeNotifier {
  final String _baseUrl = 'findjob-410cf-default-rtdb.firebaseio.com';
  final storage = const FlutterSecureStorage();
  final List<Job> jobs = [];
  late Job selectedJob;
  File? newPictureFile;
  bool isLoading = true;
  bool isSaving = false;

  JobsService() {
    loadJobs();
  }

  Future<List<Job>> loadJobs() async {
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
    isLoading = false;
    notifyListeners();
    return jobs;
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

    final index = jobs.indexWhere((element) => element.id == job.id);
    jobs[index] = job;

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

    //jobs.add();

    return '';
  }

  void updateSelectedProductImage(String path) {
    selectedJob.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }
}