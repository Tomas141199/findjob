import 'package:findjob_app/models/job_solicitud.dart';
import 'package:findjob_app/models/models.dart';
import 'package:findjob_app/services/services.dart';
import 'package:findjob_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/widget_arguments.dart';
import '../services/jobs_service.dart';
import '../widgets/postulantes.dart';
import 'loading_screen.dart';

class AspirantesScreen extends StatelessWidget {
  const AspirantesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /**Cuadro de dialogo */
    final jobsService = Provider.of<JobsService>(context);
    final userDataService = Provider.of<UserDataService>(context);
    final jobsList = jobsService.aspirantes;

    if (jobsService.isLoading) {
      return const LoadingScreen();
    }

    return Scaffold(
      backgroundColor: AppTheme.primary,
      appBar: AppBar(
        elevation: 0,
        title: const Text("FindJob",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(255, 252, 252, 1),
              fontSize: 25.0,
              fontWeight: FontWeight.w800,
              fontFamily: 'OpenSans',
            )),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 252, 252, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: ListView.builder(
          itemCount: jobsList.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () async {
              await userDataService
                  .setUserSelected(jobsList[index].idSolicitante)
                  .then((value) => {
                        print(jobsList[index].idSolicitante),
                        Navigator.pushNamed(context, 'userDetails'),
                      });
            },
            child: Hero(
              tag: jobsList[index].idSolicitante!,
              child: _SlidableItem(job: jobsList[index]),
            ),
          ),
        ),
      ),
    );
  }
}

class _SlidableItem extends StatelessWidget {
  const _SlidableItem({
    Key? key,
    required this.job,
  }) : super(key: key);

  final JobSolicitud job;

  @override
  Widget build(BuildContext context) {
    final jobsService = Provider.of<JobsService>(context);

    final chatService = Provider.of<ChatMessageService>(context);
    final List<ChatUser> chats = chatService.chats;
    jobsService.selectedJobSolicitud = this.job;

    Widget cancelButton = TextButton(
      style: AppTheme.flatButtonStyle,
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = TextButton(
      style: AppTheme.flatButtonStyle,
      child: Text("Continuar"),
      onPressed: () async {
        Navigator.of(context).pop();
        await jobsService.eliminarSolicitudesAspirante(
            jobsService.selectedJobSolicitud.idEmpleo.toString(),
            jobsService.selectedJobSolicitud.idSolicitante.toString());
      },
    );

    return Slidable(
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
                backgroundColor: Colors.blue,
                icon: Icons.call,
                label: 'Llamar',
                onPressed: (context) async {
                  const url = 'tel:+1 555 010 999';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Error $url';
                  }
                }),
            SlidableAction(
              backgroundColor: Colors.amber,
              icon: Icons.email,
              foregroundColor: Colors.white,
              label: 'Mensaje',
              onPressed: (context) {
                //Indicamos la solicitud en la que nos estamos posicionando
                jobsService.selectedJobSolicitud = job.copy();
                chatService.chatMessages.clear();
                var index = chatService.chats
                    .indexWhere((element) => element.id == job.idSolicitante);
                if (index != -1) {
                  print("Ya se tiene un chat previo con el index ${index}");
                  chatService.chatSelected = chats[index].copy();
                  chatService.loadChatMessages();
                  Navigator.pushNamed(context, 'chatScreen',
                      arguments: WidgetArguments(edit: true, action: 2));
                } else {
                  print("No se tiene un chat previo con el usuario");
                  Navigator.pushNamed(context, 'chatScreen',
                      arguments: WidgetArguments(edit: true, action: 1));
                }
              },
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
                backgroundColor: Colors.red,
                icon: Icons.archive,
                label: 'Rechazar',
                onPressed: (context) {
                  jobsService.selectedJobSolicitud = job.copy();
                  print(
                      "IdSolicitante ${jobsService.selectedJobSolicitud.idSolicitante}");
                  print(
                      "IdEmpleo ${jobsService.selectedJobSolicitud.idEmpleo}");

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Aviso"),
                        content: Text(
                            "Al continuar con esta operación se detendra el proceso de postulación para dicho aspirante. ¿Desea continuar con la operación?"),
                        actions: [
                          cancelButton,
                          continueButton,
                        ],
                      );
                    },
                  );
                })
          ],
        ),
        child: PostulanteWidget(jobSolicitud: job));
  }
}
