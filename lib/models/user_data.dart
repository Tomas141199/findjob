// To parse this JSON data, do
//
//     final userData = userDataFromMap(jsonString);

import 'dart:convert';

class UserData {
  UserData({
    this.id,
    required this.birthday,
    this.description,
    this.doc,
    required this.ownerId,
    required this.tel,
  });

  String? id;
  String birthday;
  String? description;
  String? doc;
  String ownerId;
  int tel;

  factory UserData.fromJson(String str) => UserData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        birthday: json["birthday"],
        description: json["description"],
        doc: json["doc"],
        ownerId: json["owner_id"],
        tel: json["tel"],
      );

  Map<String, dynamic> toMap() => {
        "birthday": birthday,
        "description": description,
        "doc": doc,
        "owner_id": ownerId,
        "tel": tel,
      };
}
