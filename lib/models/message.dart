import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Message{
  Message({
    this.id,
    required this.fecha,
    required this.hora,
    required this.idUser,
    required this.mensaje
  });

  String? id;
  String fecha;
  String hora;
  String mensaje;
  String idUser;

  factory Message.fromJson(String str) => Message.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Message.fromMap(Map<String, dynamic> json) => Message(
        id: json["id"],
        fecha: json["fecha"],
        hora: json["hora"],
        idUser: json["idUser"],
        mensaje: json["mensaje"]
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "fecha": fecha,
    "hora": hora,
    "idUser":idUser,
    "mensaje":mensaje
  };
}
