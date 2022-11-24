import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:findjob_app/models/models.dart';

class ChatService extends ChangeNotifier {

  final String idUsuario="usu-1";
  final String _baseUrl = 'findjob-410cf-default-rtdb.firebaseio.com';
  final List<ChatUser> chats = [];
  bool isLoading = true;

  ChatService() {
    loadChats();
  }

  Future<List<ChatUser>> loadChats() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl,'chats/$idUsuario.json');
    final resp = await http.get(url);
    final Map<String, dynamic> chatsMap = json.decode(resp.body);

    chatsMap.forEach((key, value) {
      final tempChats = ChatUser.fromMap(value);
      tempChats.id = key;
      chats.add(tempChats);
    });
    isLoading = false;
    notifyListeners();
    return chats;
  }
}
