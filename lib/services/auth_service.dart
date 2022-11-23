import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyCJETmXyVv4Oh-Fit17dFPU2rzovK-CdNs';
  final storage = const FlutterSecureStorage();

  Future<String?> createUser(
      String email, String password, String displayName) async {
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
      return null;
    } else {
      return decodedResp['error']['message'];
    }
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
