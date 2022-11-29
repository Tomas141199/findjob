import 'package:findjob_app/models/job.dart';
import 'package:findjob_app/services/services.dart';
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
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTopBar(
            idJob: job.id!,
            establishment: job.establishment,
            published: job.publishedAt,
            author: job.author,
            idEmpleador:job.authorId,
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
  final String idEmpleador;
  const _CardTopBar({
    Key? key,
    required this.idJob,
    required this.establishment,
    required this.published,
    required this.author,
    required this.idEmpleador,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final jobService = Provider.of<JobsService>(context);
    final userService = Provider.of<UserDataService>(context);

              // set up the buttons
    Widget cancelButton = TextButton(
      style: AppTheme.flatButtonStyle,
      child: Text("Cancelar"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      style: AppTheme.flatButtonStyle,
      child: Text("Continuar"),
      onPressed:  () async{     
        Navigator.of(context).pop();
        await jobService.eliminarSolicitudesAspirante(idJob,"");
        NotificationsService.showSnackBar("Se ha cancelado su postulación");
      },
    );
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom:10,top:10),
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
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
              	      textAlign: TextAlign.right,
                      establishment,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    Text(
                      "Empleador- $author \nSe postulo el- ${DateFormat('yMd').format(DateTime.parse(published))} ",
                      style: TextStyle(color: Colors.grey.shade500,fontSize: 14),
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
                    Padding(
                      padding: EdgeInsets.only(top: 10,left: 5,right: 5),
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Ver perfil del empleador'),
                        onTap: () async{
                          print("idEmpleador ${idEmpleador}");
                          await userService.setUserSelected(idEmpleador).then((value){
                            print("Datos del usuario encontrado");
                            Navigator.pushNamed(context, 'userDetails');
                            
                          });
                        },
                      ),
                    ),
                  
                    Padding(
                      padding: EdgeInsets.only(bottom:10,left: 5,right: 5),
                      child: ListTile(
                        leading: Icon(Icons.delete),
                        title: Text('Cancelar postulación'),
                        onTap: (){
                            Navigator.of(context).pop();
                            showDialog(
                            context: context,
                            builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Aviso"),
                              content: Text("Al continuar con esta operación se detendra el proceso de postulación. ¿Desea continuar con la operación?"),
                                actions: [
                                  cancelButton,
                                  continueButton,
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
          },        
          icon:Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  } 

}


