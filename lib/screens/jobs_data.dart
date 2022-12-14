import 'package:findjob_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:findjob_app/models/models.dart';
import 'package:findjob_app/services/services.dart';
import 'package:findjob_app/providers/providers.dart';
import 'package:findjob_app/theme/app_theme.dart';

class JobsData extends StatelessWidget {
  const JobsData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final jobService = Provider.of<JobsService>(context);
    return ChangeNotifierProvider(
      create: (_) => JobFormProvider(jobService.selectedJob),
      child: _JobBodyScreen(jobService: jobService),
    );
  }
}

class _JobBodyScreen extends StatelessWidget {
  const _JobBodyScreen({
    Key? key,
    required this.jobService,
  }) : super(key: key);

  final JobsService jobService;

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobsProvider>(context);

    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBarWidget(jobService: jobService),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                decoration: _backgroundScaffold(),
                child: Column(
                  children:<Widget> [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 30.0, right: 25.0, left: 25.0),
                      child: _DataJob(),
                    ),
                    Padding(
                      padding:EdgeInsets.only(bottom:40), 

                      child:JobSlider(
                        title: "Encuentra más opciones",
                        jobs: jobProvider.allJobs),
                     ),
                    
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  BoxDecoration _backgroundScaffold() {
    return const BoxDecoration(
      color: Color.fromRGBO(255, 252, 252, 1),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    );
  }
}

class _DataJob extends StatelessWidget {
  const _DataJob({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Cada accion equivale a una posición de este arreglo
    List<String> acciones = ["Postularse"];
    final userService = Provider.of<UserDataService>(context);
    final String texto;
    final args = ModalRoute.of(context)!.settings.arguments as WidgetArguments;
    bool modoEdicion = args.edit ? false : true;
    int accion = args.action;
    print("accion:${accion}");

    accion != 2 ? texto = acciones.elementAt((accion - 1)) : texto = "";

    final jobForm = Provider.of<JobFormProvider>(context);
    final job = jobForm.job;
    final jobService = Provider.of<JobsService>(context);

    Widget cancelButton = TextButton(
      style: AppTheme.flatButtonStyle,
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              'Datos generales',
              style: AppTheme.subEncabezadoDos,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(Icons.maps_home_work),
                  ),
                  TextSpan(
                    text: " Establecimiento- " + job.establishment,
                    style: AppTheme.datos,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(Icons.person),
                  ),
                  TextSpan(
                    text: "Puesto requerido- " + job.title,
                    style: AppTheme.datos,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(Icons.monetization_on),
                  ),
                  TextSpan(
                    text: job.salary.toString() +
                        "\n(El salario adjunto puede corresponder al salario semanal/quincenal, dependiendo de la disposición del empleador.)",
                    style: AppTheme.datos,
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Text(
              'Descripción',
              style: AppTheme.subEncabezadoDos,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: job.description,
                    style: AppTheme.datos,
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Text(
              'Ubicación',
              style: AppTheme.subEncabezadoDos,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(Icons.place),
                  ),
                  TextSpan(
                    text: " Dirección- " + job.address,
                    style: AppTheme.datos,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(Icons.location_city),
                  ),
                  TextSpan(
                    text: " Ciudad- " + job.city,
                    style: AppTheme.datos,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(Icons.location_city_sharp),
                  ),
                  TextSpan(
                    text: " Entidad o municipio- " + job.town,
                    style: AppTheme.datos,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Visibility(
                  visible: accion !=
                      2, //Si acción es igual a 2 el postulante esta en espera de una respuesta

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        height: 50.0,
                        onPressed: () async {
                          //Agregamos la postulación del solicitante
                          //Agregamos al aspirante al trabajo
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Aviso"),
                                content: Text(
                                    "Al postularse empezara el proceso de postulación, donde el empleador podra ponerse en contacto con usted. ¿Desea continuar?."),
                                actions: [
                                  cancelButton,
                                  TextButton(
                                    style: AppTheme.flatButtonStyle,
                                    child: Text("Continuar"),
                                    onPressed: () async {
                                      if (await jobService.postularseJob(jobForm.job,userService.authUserData.tel.toString())) {
                                        print("Postulado");
                                        await jobService
                                            .agregarAspiranteJob(jobForm.job,userService.authUserData.tel.toString());
                                        Navigator.of(context).pop();
                                        NotificationsService.showSnackBar("Su postulación ha sido enviada");
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        color: AppTheme.deepBlue,
                        child:
                            Text(texto, style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: accion == 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        height: 50.0,
                        onPressed: () async {},
                        color: AppTheme.deepBlue,
                        child: Text("Cancelar",
                            style: TextStyle(color: Colors.white)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: const Text(
                          "La solicitud ha sido enviada al empleador o empresa correspondiente. Quedando en espera de la respuesta del empleador.",
                          style: AppTheme.subEncabezadoDos,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _getTextStyleForm() {
    return const TextStyle(
      fontSize: 14.0,
      color: Colors.black,
    );
  }

  void alerta(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
      content: const Text(
          'Su postulación ha sido enviada al empleador/empresa correspondiente.'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Aceptar'),
        ),
      ],
    ));
  }
}

//Sliver bar para la sección de la imagen
class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({
    Key? key,
    required this.jobService,
  }) : super(key: key);

  final JobsService jobService;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as WidgetArguments;
    bool modoEdicion = args.edit;

    return SliverAppBar(
      backgroundColor: Color.fromRGBO(4, 135, 217, 1),
      expandedHeight: 300,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.only(bottom: 20, left: 45, right: 10),
          color: Colors.black12,
          child: Text(
            jobService.selectedJob.title,
            style: const TextStyle(fontSize: 16),
            textAlign:TextAlign.center,
          ),
        ),
        background: Opacity(
          opacity: 0.8,
          child: FadeInImage(
            placeholder: const AssetImage('assets/giphy.gif'),
            image: NetworkImage(jobService.selectedJob.picture ??
                "https://www.fcmlindia.com/images/fifty-days-campaign/no-image.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}