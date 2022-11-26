// To parse this JSON data, do
//
//     final job = jobFromMap(jsonString);

import 'dart:convert';

class JobSolicitud {
  JobSolicitud({
    this.id,
    required this.idSolicitante,
    required this.nombreSolicitante,
    required this.idEmpleo,
    required this.idEmpleador,
    required this.nombreEmpleador,
    required this.solicitadoAt,
  });

  String? id;
  String idSolicitante;
  String nombreSolicitante;
  String? idEmpleo;
  String idEmpleador;
  String nombreEmpleador;
  String solicitadoAt;

  factory JobSolicitud.fromJson(String str) => JobSolicitud.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JobSolicitud.fromMap(Map<String, dynamic> json) => JobSolicitud(
        idSolicitante: json["idSolicitante"],
        nombreSolicitante:json["nombreSolicitante"],
        idEmpleo: json["idEmpleo"],
        idEmpleador: json["idEmpleador"],
        nombreEmpleador: json["nombreEmpleador"],
        solicitadoAt: json["solicitadoAt"],
      );

  Map<String, dynamic> toMap() => {
        "idSolicitante": idSolicitante,
        "nombreSolicitante":nombreSolicitante,
        "idEmpleo": idEmpleo,
        "idEmpleador": idEmpleador,
        "nombreEmpleador": nombreEmpleador,
        "solicitadoAt": solicitadoAt,
      };

  JobSolicitud copy() => JobSolicitud(
        id: id,
        idSolicitante: idSolicitante,
        nombreSolicitante:nombreSolicitante,
        idEmpleo: idEmpleo,
        idEmpleador: idEmpleador,
        nombreEmpleador: nombreEmpleador,
        solicitadoAt: solicitadoAt,
      );
}