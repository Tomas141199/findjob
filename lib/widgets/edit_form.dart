import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';
import '../theme/app_theme.dart';
import "../validator/validator.dart";

class EditFormUser extends StatefulWidget {
  const EditFormUser({Key? key}) : super(key: key);

  @override
  _EditFormUser createState() => _EditFormUser();
}

class _EditFormUser extends State<EditFormUser> {
  bool visible = false;

  TextEditingController dateInput = TextEditingController();
  @override
  void initState() {
    dateInput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userDataService = Provider.of<UserDataService>(context);
    final userData = userDataService.authUserData.copy();
    dateInput.text = userData.birthday;

    return Form(
      key: userDataService.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: TextFormField(
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),

              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                ),
                labelText: "Nombre",
                hintText: 'Juan Perez Hernandez',
              ),
              //Se valida el texto que se recibe
              initialValue: userData.displayName,
              validator: (value) {
                return value!.notEmpty;
              },
              onChanged: (value) => userData.displayName = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9]{0,10}$'),
                ),
              ],
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),

              decoration: const InputDecoration(
                labelText: "Telefono",
                hintText: '*******890',
                prefixIcon: Icon(
                  Icons.phone,
                ),
              ),

              //Se valida el texto que se recibe
              initialValue: userData.tel.toString(),
              validator: (value) {
                return value!.notEmpty;
              },
              onChanged: (value) => userData.tel = int.parse(value),
            ),
          ),

          /**TextFormField:Correo electronico */

          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                labelText: "Correo",
                hintText: "job@gmail.com",
                prefixIcon: Icon(
                  Icons.alternate_email_rounded,
                ),
              ),
              validator: (value) {
                return value!.isValidEmail;
              },
              initialValue: userData.contactEmail,
              onChanged: (value) => userData.contactEmail = value,
            ),
          ),

          /**TextFormField:Fecha de nacimiento */
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextFormField(
              controller: dateInput,
              readOnly: true,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                labelText: "Fecha Nacimiento",
                hintText: 'aa/mm/dd',
                prefixIcon: Icon(Icons.cake), //icon of text field
              ),
              onChanged: (value) => userData.birthday = value,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2100));
                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  userData.birthday = formattedDate;
                  setState(() {
                    dateInput.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {}
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextFormField(
              maxLines: 4, //or null
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              initialValue: userData.description ?? "",
              onChanged: (value) => userData.description = value,
              //Decoración del textFormField
              decoration: const InputDecoration(
                labelText: 'Descripción del usuario',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              FloatingActionButton(
                elevation: 0,
                onPressed: () async {
                  final result =
                      await FilePicker.platform.pickFiles(allowMultiple: false);
                  if (result == null) return;
                  final file = result.files.first;
                  userDataService.updateSelectedUserDoc(file.path!);
                  NotificationsService.showSnackBar(
                      "${file.name} cargado correctamente");
                },
                child: const Icon(Icons.upload_file_rounded),
              ),
              const SizedBox(height: 10),
              const Text("Subir CV o Documento"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              height: 50.0,
              onPressed: userDataService.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      if (!userDataService.isValidForm()) return;
                      userDataService.authUserData = userData.copy();
                      print("Actualizando datos del usuario");

                      String? newDocUrl = await userDataService.uploadFile();
                      if (newDocUrl != null) {
                        String? docJPG =
                            newDocUrl.replaceFirst(RegExp(r".pdf"), ".jpg");
                        userDataService.authUserData.docUrl = docJPG;
                      }

                      await userDataService.updateCurrentUser();
                      NotificationsService.showSnackBar("Cambios guardados");
                    },
              color: AppTheme.primary,
              child: Text(userDataService.isLoading ? 'Espere' : 'Guardarr',
                  style: TextStyle(
                      color: userDataService.isLoading
                          ? Colors.black
                          : Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
