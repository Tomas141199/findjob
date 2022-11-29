import 'package:findjob_app/models/job_solicitud.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

import '../theme/app_theme.dart';

class PostulanteWidget extends StatelessWidget {
  final JobSolicitud jobSolicitud;
  const PostulanteWidget({super.key, required this.jobSolicitud});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        title: Text(jobSolicitud.nombreSolicitante,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
        subtitle: Text(
          "Postulado - ${DateFormat('yMd').format(DateTime.parse(jobSolicitud.solicitadoAt))}",
          style: TextStyle(color: Colors.grey.shade500,fontSize: 14),
        ),
        leading: CircleAvatar(
          backgroundColor: AppTheme.getRandomColor(),
          radius: 26,
          child: Text(
            jobSolicitud.nombreSolicitante[0],
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ));
  }
}
