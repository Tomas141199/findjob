import 'package:findjob_app/models/job.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../services/jobs_service.dart';
import '../theme/app_theme.dart';

class JobCardDos extends StatelessWidget{
  final Job job;
  const JobCardDos({super.key, required this.job});

  @override
  Widget build(BuildContext context){


    return Container(

      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTopBar(
            idJob:job.id!,
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
  final String establishment;
  final String published;
  final String author;
  final String idJob;

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
        children: [
          CircleAvatar(
            backgroundColor: AppTheme.getRandomColor(),
            child: Text(
              establishment[0],
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
                    establishment,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Oferta publicada el- ${DateFormat('yMd').format(DateTime.parse(published))}",
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
                            leading: Icon(Icons.group),
                            title: Text('Ver postulantes'),
                            onTap: () async {
                              if(await jobService.loadPostulantes(idJob)){
                                Navigator.of(context).pop();
                                Navigator.pushNamed(context, 'aspirantes');
                              }else{
                                Navigator.of(context).pop();
                                alerta(context);
                              }
                            },
                          ),
                        ),
                  
                        Padding(padding: EdgeInsets.only(bottom:10,left: 5,right: 5),
                          child: ListTile(
                            leading: Icon(Icons.delete),
                            title: Text('Eliminar publicación'),
                            onTap: () async {
                              Navigator.of(context).pop();
                              showDialog(
                            context: context,
                            builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Aviso"),
                              content: Text("Los datos relacionados con la oferta laboral seran eliminados en su totalidad. ¿Desea continuar?"),
                                actions: [
                                  _cancelButton(context),
                                  TextButton(
                                      style: AppTheme.flatButtonStyle,
                                      child: Text("Continuar"),
                                      onPressed:  () async{     
                                        await jobService.eliminarJobs(idJob);                                        
                                
                                        Navigator.of(context).pop();
                                        },  
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },        
                );
              //bpp,
            }, 
            icon:Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }

  Widget _cancelButton(BuildContext context){
    return TextButton(
      style: AppTheme.flatButtonStyle,
      child: Text("Cancelar"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
  }

   void alerta(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('No se han encontrado postulantes'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Aceptar'),
          ),
        ],
      )
    );
  }
}
