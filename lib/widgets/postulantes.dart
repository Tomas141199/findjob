import 'package:findjob_app/models/job_solicitud.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

import '../theme/app_theme.dart';

class PostulanteWidget extends StatelessWidget{
  final JobSolicitud jobSolicitud;
  const PostulanteWidget({super.key,required this.jobSolicitud});

  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child:Column(
        children:<Widget>[
          _CardTopBar(
            published: jobSolicitud.solicitadoAt,
            postulante: jobSolicitud.nombreSolicitante,
          ),
        ],
      ),
    );
  }
}

class _CardTopBar extends StatelessWidget {
  final String published;
  final String postulante;

  const _CardTopBar({
    Key? key,
    required this.published,
    required this.postulante,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: AppTheme.getRandomColor(),
            child: Text(
              postulante[0],
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          
          Expanded(
            child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                   Text(
              	    textAlign: TextAlign.right,
                    postulante,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Postulado- ${DateFormat('yMd').format(DateTime.parse(published))}",
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  ],  
                ),
              ),
            ],
          ),
          ),

          IconButton(
            onPressed: (){
              print("Mostrar menu de opciones");
            }, 
            icon:Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
