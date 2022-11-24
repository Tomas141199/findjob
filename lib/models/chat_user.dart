import 'dart:convert';

class ChatUser {
  ChatUser({
    this.id,
    required this.usuario,
    required this.ultimoMensaje
  });

  String? id;
  String usuario;
  String ultimoMensaje;

  factory ChatUser.fromJson(String str) => ChatUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatUser.fromMap(Map<String, dynamic> json) => ChatUser(
        id: json["id"],
        usuario: json["usuario"],
        ultimoMensaje: json["ultimoMensaje"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "usuario": usuario,
        "ultimoMensaje":ultimoMensaje,
      };
}
