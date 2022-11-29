import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:findjob_app/models/models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserDataService extends ChangeNotifier {
  final String _baseUrl = 'findjob-410cf-default-rtdb.firebaseio.com';
  final storage = const FlutterSecureStorage();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late UserData selectedUser;
  File? newPictureFile;
  late UserData authUserData;
  bool isLoading = true;
  File? newDocumentFile;

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

  updateCurrentUser() async {
    isLoading = true;
    print(authUserData.displayName);
    notifyListeners();
    final url = Uri.https(_baseUrl, 'userdata/${authUserData.id}.json');
    final resp = await http.put(url, body: authUserData.toJson());
    final decodeData = resp.body;

    print(decodeData);

    isLoading = false;
    notifyListeners();
  }

  void updateSelectedUserImage(String path) {
    authUserData.photoUrl = path;
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

  void updateSelectedUserDoc(String path) {
    newDocumentFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadFile() async {
    if (newDocumentFile == null) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        "https://api.cloudinary.com/v1_1/dpjcpceqb/image/upload?upload_preset=ofsmrn7w");
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file =
        await http.MultipartFile.fromPath('file', newDocumentFile!.path);

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

  bool isValidForm() {
    print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
  }
}
