import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:findjob_app/models/models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserDataService extends ChangeNotifier {
  final String _baseUrl = 'findjob-410cf-default-rtdb.firebaseio.com';
  final storage = const FlutterSecureStorage();

  late UserData selectedUser;
  File? newPictureFile;
  late UserData authUserData;
  bool isLoading = true;
  bool isSaving = false;

  UserDataService() {
    loadCurrentUser();
  }

  Future loadCurrentUser() async {
    final String id = await storage.read(key: "user_id") ?? '';
    loadUserData(id);
  }

  Future loadUserData(String id) async {
    isLoading = true;
    notifyListeners();

    final parameter = {
      "orderBy": '"owner_id"',
      "equalTo": '"$id"',
    };

    final url = Uri.https(_baseUrl, 'userdata.json', parameter);
    final resp = await http.get(url);
    final Map<String, dynamic> dataMap = json.decode(resp.body);

    print(url);

    dataMap.forEach((key, value) {
      authUserData = UserData.fromMap(value);
      authUserData.id = key;
    });

    isLoading = false;
    notifyListeners();
  }

  Future setUserSelected(String id) async {
    isLoading = true;
    notifyListeners();
    final parameter = {
      "orderBy": '"owner_id"',
      "equalTo": '"$id"',
    };
    final url = Uri.https(_baseUrl, 'userdata.json', parameter);
    final resp = await http.get(url);
    final Map<String, dynamic> dataMap = json.decode(resp.body);

    print(url);

    dataMap.forEach((key, value) {
      selectedUser = UserData.fromMap(value);
      selectedUser.id = key;
    });

    isLoading = false;
    notifyListeners();
  }
}
