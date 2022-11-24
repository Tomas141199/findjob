import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:findjob_app/models/models.dart';
import 'package:intl/intl.dart';

class ChatMessageService extends ChangeNotifier {

  final String idUsuario="usu-1"; //Este ID debe corresponder al del remitente
  final String idUsuarioDos="usu-2"; //Este debe corresponder al del destinatario
  final String _baseUrl = 'findjob-410cf-default-rtdb.firebaseio.com';
  final List<Message> chatMessages = [];
  final String _firebaseToken = 'AIzaSyCJETmXyVv4Oh-Fit17dFPU2rzovK-CdNs';
  final storage = new FlutterSecureStorage();
  bool isLoading = true;

  ChatMessageService() {
    loadChatMessages();
  }

  Future<List<Message>> loadChatMessages() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl,'chatMessages/$idUsuario/$idUsuarioDos.json');
    final resp = await http.get(url);
    final Map<String, dynamic> chatMessagesMap = json.decode(resp.body);

    chatMessages.clear();
    chatMessagesMap.forEach((key, value) {
      final tempChatsMessages = Message.fromMap(value);
      tempChatsMessages.id = key;
      chatMessages.add(tempChatsMessages);
    });

    //Ordenamos el arreglo por la fecha
    chatMessages.sort((a, b) {
      return a.hora.replaceAll(":", "").compareTo(b.hora.replaceAll(":", ""));
    });

    isLoading = false;
    notifyListeners();
    print(chatMessages.length);
    return chatMessages;
  }

  Future<String?> crearMensaje(
    String fecha, String hora, String idUser, String mensaje) async {
    
    final Map<String, dynamic> mensajeDatos = {
      'fecha': fecha,
      'hora':hora,
      'idUser': idUser,
      'mensaje': mensaje,
    };

    final url = Uri.https(_baseUrl, 'chatMessages/$idUsuario/$idUsuarioDos.json', {
      'key': _firebaseToken,
    });

    final resp = await http.post(url, body: json.encode(mensajeDatos));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);


    if(decodedResp.containsKey("idToken")) {
      await storage.write(key: "token", value: decodedResp['idToken']);
      loadChatMessages();
      return null;
    } else {
      loadChatMessages();
      return decodedResp['error']['message'];
    }
  }
}
