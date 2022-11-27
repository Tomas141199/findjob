import 'package:findjob_app/models/job_solicitud.dart';
import 'package:findjob_app/services/services.dart';
import 'package:findjob_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/jobs_service.dart';
import '../widgets/postulantes.dart';
import 'loading_screen.dart';

class AspirantesScreen extends StatelessWidget {
  const AspirantesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  .setUserSelected(jobsList[index].idSolicitante);
              print(jobsList[index].idSolicitante);
              Navigator.pushNamed(context, 'userProfile');
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
              onPressed: (context) {},
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
                onPressed: (context) {})
          ],
        ),
        child: PostulanteWidget(jobSolicitud: job));
  }
}
