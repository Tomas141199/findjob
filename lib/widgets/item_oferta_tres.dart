import 'package:findjob_app/models/job.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../services/jobs_service.dart';
import '../theme/app_theme.dart';

class JobCardTres extends StatelessWidget{
  final Job job;
  const JobCardTres({super.key, required this.job});

  @override
  Widget build(BuildContext context){

    return Container(

      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTopBar(
            idJob: job.id!,
            establishment: job.establishment,
            published: job.publishedAt,
            author: job.author,
          ),
        ],
      ),
    );
  }
}

class _CardTopBar extends StatelessWidget {
  final String idJob;
  final String establishment;
  final String published;
  final String author;

  const _CardTopBar({
    Key? key,
    required this.idJob,
    required this.establishment,
    required this.published,
    required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final jobService = Provider.of<JobsService>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        CircleAvatar(
          backgroundColor: AppTheme.getRandomColor(),
          child: Text(
            establishment[0],
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
              	    textAlign: TextAlign.right,
                    establishment,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Empleador- $author \nSe postulo el- ${DateFormat('yMd').format(DateTime.parse(published))} ",
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
          showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
          ),
          context: context,
            builder: (context) {
              return Wrap(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 10,left: 5,right: 5),
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Ver perfil del empleador'),
                    ),
                  ),
                  
                  Padding(padding: EdgeInsets.only(bottom:10,left: 5,right: 5),
                    child: ListTile(
                      leading: Icon(Icons.delete),
                      title: Text('Cancelar postulación'),
                      onTap: ()async{
                        await jobService.eliminarPostulacionesAspirante(idJob);
                        await jobService.eliminarSolicitudesAspirante(idJob);
                        
                      },
                    ),
                  ),
                ],
              );
            },        
          );
        }, 
            icon:Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
