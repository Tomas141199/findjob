import 'dart:convert';

class UserData {
  UserData({
    this.id,
    required this.birthday,
    required this.contactEmail,
    this.description,
    required this.displayName,
    this.docUrl,
    required this.ownerId,
    this.photoUrl,
    required this.tel,
  });

  String? id;
  String birthday;
  String contactEmail;
  String? description;
  String displayName;
  String? docUrl;
  String ownerId;
  String? photoUrl;
  int tel;

  factory UserData.fromJson(String str) => UserData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        birthday: json["birthday"],
        contactEmail: json["contactEmail"],
        description: json["description"],
        displayName: json["displayName"],
        docUrl: json["docUrl"],
        ownerId: json["owner_id"],
        photoUrl: json["photoUrl"],
        tel: json["tel"],
      );

  Map<String, dynamic> toMap() => {
        "birthday": birthday,
        "contactEmail": contactEmail,
        "description": description,
        "displayName": displayName,
        "docUrl": docUrl,
        "owner_id": ownerId,
        "photoUrl": photoUrl,
        "tel": tel,
      };

  UserData copy() => UserData(
        id: id,
        birthday: birthday,
        contactEmail: contactEmail,
        description: description,
        displayName: displayName,
        docUrl: docUrl,
        ownerId: ownerId,
        photoUrl: photoUrl,
        tel: tel,
      );
}
