import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:findjob_app/helpers/debouncer.dart';
import 'package:findjob_app/models/models.dart';

class JobsProvider extends ChangeNotifier {
  final String _baseUrl = 'findjob-410cf-default-rtdb.firebaseio.com';
  List<Job> allJobs = [];
  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Job>> _suggestionStreamContoller =
      StreamController.broadcast();
  Stream<List<Job>> get suggestionStream => _suggestionStreamContoller.stream;

  JobsProvider() {
    print('MoviesProvider inicializado');
    getAllJobs();
  }

  getAllJobs() async {
    final url = Uri.https(_baseUrl, 'jobs.json');
    final resp = await http.get(url);
    final Map<String, dynamic> jobsMap = json.decode(resp.body);

    jobsMap.forEach((key, value) {
      final tempJob = Job.fromMap(value);
      tempJob.id = key;
      allJobs.add(tempJob);
    });

    notifyListeners();
  }

  searchMovies(String query) async {
    final parameters = {
      "orderBy": '"title"',
      "startAt": '"$query"',
    };
    final url = Uri.https(_baseUrl, 'jobs.json', parameters);
    print(url);
    final response = await http.get(url);
    final List<Job> searchResponse = [];

    final Map<String, dynamic> jobsMap = json.decode(response.body);

    jobsMap.forEach((key, value) {
      final tempJob = Job.fromMap(value);
      tempJob.id = key;
      searchResponse.add(tempJob);
    });

    return searchResponse;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      // print('Tenemos valor a buscar: $value');
      final results = await searchMovies(value);
      _suggestionStreamContoller.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}
