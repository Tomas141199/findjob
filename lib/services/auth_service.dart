import 'package:findjob_app/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyCJETmXyVv4Oh-Fit17dFPU2rzovK-CdNs';
  final storage = const FlutterSecureStorage();

  Future<String?> createUser(String email, String password, String displayName,
      int tel, String birthday) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'displayName': displayName,
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key': _firebaseToken,
    });

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey("idToken")) {
      await storage.write(key: "token", value: decodedResp['idToken']);
      await storage.write(key: "user_name", value: decodedResp['displayName']);
      await storage.write(key: "user_id", value: decodedResp['localId']);

      final userdata = UserData(
          birthday: birthday,
          ownerId: decodedResp['localId'],
          tel: tel,
          contactEmail: email,
          displayName: displayName
        );

      await addUserData(userdata);

      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future<String?> addUserData(UserData data) async {
    const String baseUrlData = "findjob-410cf-default-rtdb.firebaseio.com";
    final url = Uri.https(baseUrlData, 'userdata.json');
    final resp = await http.post(url, body: data.toJson());
    print("Data convertida");
    print(data.toJson());
    print(resp.body);
    final decodeData = json.decode(resp.body);

    data.id = decodeData['name'];

    return data.id!;
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
      'key': _firebaseToken,
    });

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (decodedResp.containsKey("idToken")) {
      await storage.write(key: "token", value: decodedResp['idToken']);
      await storage.write(key: "user_name", value: decodedResp['displayName']);
      await storage.write(key: "user_id", value: decodedResp['localId']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future logout() async {
    await storage.delete(key: "token");
    await storage.delete(key: "user_name");
    await storage.delete(key: "user_id");
    return null;
  }

  Future<String> readToken() async {
    return await storage.read(key: "token") ?? '';
  }
}
