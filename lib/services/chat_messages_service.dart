import 'dart:convert';
import 'package:findjob_app/services/jobs_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:findjob_app/models/models.dart';
import 'package:intl/intl.dart';

import '../models/job_solicitud.dart';

class ChatMessageService extends ChangeNotifier {

  final String _baseUrl = 'findjob-410cf-default-rtdb.firebaseio.com';
  final List<ChatMessage> chatMessages = [];
  final storage = new FlutterSecureStorage();
  bool isLoading = true;

  final List<ChatUser> chats = [];
  late ChatUser chatSelected;
  late String idUsuarioActual;

  ChatMessageService() {
    loadChats();
    
  }

  Future<List<ChatUser>> loadChats() async {
    idUsuarioActual= await storage.read(key: "user_id") ?? '';
    print("Id usuario actual+ $idUsuarioActual");
    chats.clear();
    isLoading = true;
    notifyListeners();
    var autor = await storage.read(key: "user_id") ?? '';
    final url = Uri.https(_baseUrl,'chats/$autor.json');

    await http.get(url).then((value){
      final Map<String, dynamic> chatMessagesMap = json.decode(value.body);
      print("Las solicitudes se han encontrado");

      chatMessagesMap.forEach((key, value) {
        final tempChatsMessages = ChatUser.fromMap(value);
        tempChatsMessages.id = key;
        chats.add(tempChatsMessages);
      });

      print("Número de chats: ${chats.length}");

    }).catchError((onError){
      print("Ha ocurrido un error durante la carga de mis chats");
    });
  
    isLoading = false;
    notifyListeners();
    return chats;
  }

  Future<void> loadChatMessages()async{
    var autor = await storage.read(key: "user_id") ?? '';
    final url = Uri.https(_baseUrl,'chatMessages/$autor/${chatSelected.id}.json');
    
    await http.get(url).then((value){
      final Map<String, dynamic> mensajes = json.decode(value.body);
      print("Mensajes encontrados");
      
      _cargarMensajes(mensajes);

    }).catchError((onError){
      
      //Si sucede un error indica que ruta esta incorrecta
      final url_ = Uri.https(_baseUrl,'chatMessages/${chatSelected.id}/$autor.json');
      http.get(url_).then((value){
        final Map<String, dynamic> mensajes_ = json.decode(value.body);
        print("Mensajes encontrados en la segunda vuelta");
        _cargarMensajes(mensajes_);
      }).catchError((onError){
        print("Ha ocurrido otro error");
      });
      
      print("Mensajes no encontrados");

    });
    
  }

  Future<List<ChatMessage>> _cargarMensajes(var mensajes) async{
    isLoading = false;
    notifyListeners();
    chatMessages.clear();
    mensajes.forEach((key, value) {
      final tempChatsMessages = ChatMessage.fromMap(value);
      tempChatsMessages.id = key;
      print("mensaje: ${tempChatsMessages.mensaje}");
      chatMessages.add(tempChatsMessages);
    });

    isLoading = false;
    notifyListeners();
    return chatMessages;
  }  

  Future<void> crearMensaje(
    JobSolicitud job, String mensaje) async {

    var nombre_usuario = await storage.read(key: "user_name") ?? '';
    var autor = await storage.read(key: "user_id") ?? '';

    final Map<String, dynamic> mensajeDatos = {
      'idUser': autor,
      'mensaje': mensaje,
      'enviadoAt': DateTime.now().toString(),
    };

    final url = Uri.https(_baseUrl, 'chatMessages/$autor/${job.idSolicitante}.json');
    final response=await http.get(url);
    //Verificamos si la ruta ha sido creada
    
    await http.post(url,body: json.encode(mensajeDatos)).then((value){
        print("Mensaje enviado y guardado");

        /*Altualizamos los chats del lado del remitente*/
        /*--------------------------------------------*/
        final Map<String, dynamic> chatDatos = {
          'usuario_destinatario': job.nombreSolicitante,
          'ultimo_mensaje': mensaje,
          'fecha':DateTime.now().toString(),
        };
        
        final url_ = Uri.https(_baseUrl, 'chats/$autor/${job.idSolicitante}.json');
          http.put(url_,body: json.encode(chatDatos)).then((value){
          print("Chat actualizado remitente");
        }).catchError((e){
          print("Chat no actualizado remitente");
        });

        /*Altualizamos los chats del lado del destinatario*/
        /*------------------------------------------------*/
        final Map<String, dynamic> chatDatos_ = {
          'usuario_destinatario': nombre_usuario,
          'ultimo_mensaje': mensaje,
          'fecha':DateTime.now().toString(),
        };
        
        //Altualizamos los chats del lado del destinatario
        final urlDos = Uri.https(_baseUrl, 'chats/${job.idSolicitante}/$autor.json');
          http.put(urlDos,body: json.encode(chatDatos_)).then((value){
          print("Chat actualizado destinatario");
        }).catchError((e){
          print("Chat no actualizado destinatario");
        });
        loadChats();
        chatSelected=chats.last;
        loadChatMessages();

    }).catchError((onError){
      print("Mensaje no enviado");
    });
    
  }

Future<void> crearMensajeDos(
    ChatUser mensaje, String mensajeNuevo) async {

    var nombre_usuario = await storage.read(key: "user_name") ?? '';
    var autor = await storage.read(key: "user_id") ?? '';

    final Map<String, dynamic> mensajeDatos = {
      'idUser': autor,
      'mensaje': mensajeNuevo,
      'enviadoAt': DateTime.now().toString(),
    };

    var url = Uri.https(_baseUrl, 'chatMessages/$autor/${mensaje.id}.json');
    final response=await http.get(url);
    
    try{
      final Map<String, dynamic> mensajes = json.decode(response.body);
      print("Chat correcto");
    }catch(E){
      url = Uri.https(_baseUrl, 'chatMessages/${mensaje.id}/$autor.json');
      print("Chat incorrecto");
    } 
    
    await http.post(url,body: json.encode(mensajeDatos)).then((value){
        print("Mensaje enviado y guardado");

        /*Altualizamos los chats del lado del remitente*/
        /*--------------------------------------------*/
        final Map<String, dynamic> chatDatos = {
          'usuario_destinatario': mensaje.usuario_destinatario,
          'ultimo_mensaje': mensajeNuevo,
          'fecha':DateTime.now().toString(),
        };

        final url_ = Uri.https(_baseUrl, 'chats/$autor/${mensaje.id}.json');
          http.put(url_,body: json.encode(chatDatos)).then((value){
          print("Chat actualizado remitente");
        }).catchError((e){
          print("Chat no actualizado remitente");
        });


        /*Altualizamos los chats del lado del destinatario*/
        /*------------------------------------------------*/
        final Map<String, dynamic> chatDatos_ = {
          'usuario_destinatario': nombre_usuario,
          'ultimo_mensaje': mensajeNuevo,
          'fecha':DateTime.now().toString(),
        };
        
        //Altualizamos los chats del lado del destinatario
        final urlDos = Uri.https(_baseUrl, 'chats/${mensaje.id}/$autor.json');
          http.put(urlDos,body: json.encode(chatDatos_)).then((value){
          print("Chat actualizado destinatario");
        }).catchError((e){
          print("Chat no actualizado destinatario");
        });

        loadChatMessages();
    });

  }

  
}
