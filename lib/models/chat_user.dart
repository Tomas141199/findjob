// To parse this JSON data, do
//
//     final job = jobFromMap(jsonString);

import 'dart:convert';

class ChatUser {
  ChatUser({
    this.id,
    required this.fecha,
    required this.ultimo_mensaje,
    required this.usuario_destinatario,
  });

  String? id; //Correspondera al id del usuario
  String fecha;
  String ultimo_mensaje;
  String usuario_destinatario;

  factory ChatUser.fromJson(String str) => ChatUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatUser.fromMap(Map<String, dynamic> json) => ChatUser(
        id: json["id"],
        fecha: json["fecha"],
        ultimo_mensaje: json["ultimo_mensaje"],
        usuario_destinatario:json["usuario_destinatario"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "fecha": fecha,
        "ultimo_mensaje":ultimo_mensaje,
        "usuario_destinatario":usuario_destinatario,
      };

  ChatUser copy() => ChatUser(
    id: id,
    fecha: fecha,    
    ultimo_mensaje: ultimo_mensaje,
    usuario_destinatario: usuario_destinatario,
    
  );
}
