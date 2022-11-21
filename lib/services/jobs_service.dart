import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:findjob_app/models/models.dart';

class JobsService extends ChangeNotifier {
  final String _baseUrl = 'findjob-410cf-default-rtdb.firebaseio.com';
  final List<Job> jobs = [];
  bool isLoading = true;

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
}
