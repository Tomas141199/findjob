import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:findjob_app/services/services.dart';
import 'package:findjob_app/providers/providers.dart';
import 'package:findjob_app/validator/validator.dart';
import 'package:findjob_app/widgets/widgets.dart';
import 'package:findjob_app/theme/app_theme.dart';
import 'package:image_picker/image_picker.dart';

class AddJobScreen extends StatelessWidget {
  const AddJobScreen({Key? key}) : super(key: key);

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
    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: SingleChildScrollView(
        child: Container(
          decoration: _backgroundScaffold(),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Stack(
                  children: [
                    JobImage(
                      url: jobService.selectedJob.picture,
                    ),
                    Positioned(
                      top: 60,
                      left: 20,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      right: 20,
                      child: IconButton(
                        onPressed: () async {
                          final picker = ImagePicker();
                          final PickedFile? pickedFile = await picker.getImage(
                              source: ImageSource.camera, imageQuality: 100);

                          if (pickedFile == null) {
                            print('no selecciono nada');
                            return;
                          }
                          print('Tenemos imagen ${pickedFile.path}');
                          jobService
                              .updateSelectedProductImage(pickedFile.path);
                        },
                        icon: const Icon(
                          Icons.camera_alt_rounded,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30.0, right: 25.0, left: 25.0),
                  child: _FormJob(),
                ),
              ]),
        ),
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

class _FormJob extends StatelessWidget {
  const _FormJob({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final jobForm = Provider.of<JobFormProvider>(context);
    final job = jobForm.job;
    final jobService = Provider.of<JobsService>(context);

    return Form(
      key: jobForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
            padding: const EdgeInsets.only(top: 20.0),
            child: TextFormField(
              style: _getTextStyleForm(),
              //Decoración del elemento
              decoration: const InputDecoration(
                labelText: 'Establecimiento',
                prefixIcon: Icon(Icons.maps_home_work),
                hintText: "Ejem. Walmart",
              ),
              validator: (value) {
                return value!.notEmpty;
              },
              initialValue: job.establishment,
              onChanged: (value) => job.establishment = value,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextFormField(
              style: _getTextStyleForm(),
              //Decoración del input
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: 'Puesto requerido',
                hintText: "Ejem: Ayudante de piso",
              ),
              validator: (value) {
                return value!.notEmpty;
              },
              initialValue: job.title,
              onChanged: (value) => job.title = value,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              style: _getTextStyleForm(),
              //Decoración del textFormField
              decoration: const InputDecoration(
                labelText: 'Sueldo',
                prefixIcon: Icon(Icons.monetization_on),
                hintText: "Ejem: 100mxn",
              ),
              validator: (value) {
                return value!.notEmpty;
              },
              initialValue: '${job.salary}',
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ],
              onChanged: (value) {
                if (double.tryParse(value) == null) {
                  job.salary = 0;
                } else {
                  job.salary = double.parse(value);
                }
              },
            ),
          ),

          //Sección de la descripción del empleo
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextFormField(
              maxLines: 4, //or null
              style: _getTextStyleForm(),
              //Decoración del textFormField
              decoration: const InputDecoration(
                labelText: 'Descripción del empleo',
                hintText:
                    "Ejem: Ayudante de piso solo manejo de inventario de 12hrs",
              ),
              validator: (value) {
                return value!.notEmpty;
              },
              initialValue: job.description,
              onChanged: (value) => job.description = value,
            ),
          ),

          /**DATOS DE LA UBICACIÓN DEL LUGAR*/
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              'Datos de localización',
              style: AppTheme.subEncabezadoDos,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextFormField(
              style: _getTextStyleForm(),

              //Decoración del textFormField
              decoration: const InputDecoration(
                labelText: 'Dirección',
                prefixIcon: Icon(Icons.place),
                hintText: 'Av. Siempre viva #223',
              ),
              validator: (value) {
                return value!.notEmpty;
              },
              initialValue: job.address,
              onChanged: (value) => job.address = value,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextFormField(
              style: _getTextStyleForm(),

              //Decoración del textFormField
              decoration: const InputDecoration(
                labelText: 'Ciudad',
                prefixIcon: Icon(Icons.location_city),
                hintText: 'Ejem: Monterrey',
              ),
              validator: (value) {
                return value!.notEmpty;
              },
              initialValue: job.city,
              onChanged: (value) => job.city = value,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextFormField(
              style: _getTextStyleForm(),
              //Decoración del textFormField
              decoration: const InputDecoration(
                labelText: 'Municipio/Entidad',
                prefixIcon: Icon(Icons.location_city_sharp),
                hintText: "Ejem: Los mochis sinaloa",
              ),
              validator: (value) {
                return value!.notEmpty;
              },
              initialValue: job.town,
              onChanged: (value) => job.town = value,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              height: 50.0,
              onPressed: () async {
                if (!jobForm.isValidForm()) return;
                await jobService.saveOrCreateJob(jobForm.job);
              },
              color: AppTheme.deepBlue,
              child:
                  const Text('Publicar', style: TextStyle(color: Colors.white)),
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
}
