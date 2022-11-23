// To parse this JSON data, do
//
//     final job = jobFromMap(jsonString);

import 'dart:convert';

class Job {
  Job({
    this.id,
    required this.author,
    required this.authorId,
    required this.description,
    this.picture,
    required this.publishedAt,
    required this.salary,
    required this.title,
    required this.establishment,
    required this.city,
    required this.address,
    required this.town,
  });

  String? id;
  String author;
  String authorId;
  String description;
  String? picture;
  String publishedAt;
  double salary;
  String title;
  String establishment;
  String city;
  String address;
  String town;

  factory Job.fromJson(String str) => Job.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Job.fromMap(Map<String, dynamic> json) => Job(
        author: json["author"],
        authorId: json["author_id"],
        description: json["description"],
        picture: json["picture"],
        publishedAt: json["published_at"],
        salary: json["salary"].toDouble(),
        title: json["title"],
        establishment: json["establishment"],
        city: json["city"],
        address: json["address"],
        town: json["town"],
      );

  Map<String, dynamic> toMap() => {
        "author": author,
        "author_id": authorId,
        "description": description,
        "picture": picture,
        "published_at": publishedAt,
        "salary": salary,
        "title": title,
        "establishment": establishment,
        "city": city,
        "address": address,
        "town": town,
      };

  Job copy() => Job(
        id: id,
        author: author,
        authorId: authorId,
        description: description,
        picture: picture,
        publishedAt: publishedAt,
        salary: salary,
        title: title,
        establishment: establishment,
        city: city,
        address: address,
        town: town,
      );
}
