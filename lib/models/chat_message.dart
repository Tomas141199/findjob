// To parse this JSON data, do
//
//     final job = jobFromMap(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

class ChatMessage{
  ChatMessage({
    this.id,
    required this.idUser, //El usuario que envia el mensaje
    required this.mensaje,
    required this.enviadoAt,
  });

  String? id;
  String mensaje;
  String idUser;
  String enviadoAt;

  factory ChatMessage.fromJson(String str) => ChatMessage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromMap(Map<String, dynamic> json) => ChatMessage(
        id: json["id"],
        idUser: json["idUser"],
        mensaje: json["mensaje"],
        enviadoAt: json["enviadoAt"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "idUser":idUser,
        "mensaje":mensaje,
        "enviadoAt":enviadoAt
      };
}
