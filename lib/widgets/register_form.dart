import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../services/services.dart';
import '../theme/app_theme.dart';
import "../validator/validator.dart";

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterForm createState() => _RegisterForm();
}

class _RegisterForm extends State<RegisterForm> {
  bool visible = false;

  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);

    final args = ModalRoute.of(context)!.settings.arguments as WidgetArguments;
    bool modoEdicion = args.edit;

    return Form(
      key: registerForm.formKey,
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
              validator: (value) {
                return value!.notEmpty;
              },
              onChanged: (value) => registerForm.name = value,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextFormField(
              obscureText: !visible,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),

              decoration: InputDecoration(
                labelText: "Contraseña",
                hintText: '*********',
                prefixIcon: const Icon(
                  Icons.lock,
                ),
                suffixIcon: IconButton(
                  icon: Icon(visible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(
                      () {
                        visible = !visible;
                      },
                    );
                  },
                ),
              ),

              //Se valida el texto que se recibe
              validator: (value) {
                return value!.isValidPassword;
              },
              onChanged: (value) => registerForm.password = value,
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
              validator: (value) {
                return value!.notEmpty;
              },
              onChanged: (value) => registerForm.phone = value,
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
              onChanged: (value) => registerForm.email = value,
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

              //Se valida el texto que se recibe
              validator: (value) {
                return value!.notEmpty;
              },
              onChanged: (value) => registerForm.bth = value,
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
                  registerForm.bth = formattedDate;
                  setState(() {
                    dateInput.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {}
              },
            ),
          ),

          //El siguiente campo solo se muestra en el modo de edición del formulario
          Visibility(
            visible: modoEdicion,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextFormField(
                maxLines: 4, //or null
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),

                //Decoración del textFormField
                decoration: const InputDecoration(
                  labelText: 'Descripción del usuario',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              height: 50.0,
              onPressed: registerForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!registerForm.isValidForm()) return;

                      registerForm.isLoading = true;

                      print(registerForm.phone);
                      print(registerForm.bth);

                      final String? errorMessage = await authService.createUser(
                        registerForm.email,
                        registerForm.password,
                        registerForm.name,
                        int.parse(registerForm.phone),
                        registerForm.bth,
                      );

                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, 'home');
                      } else {
                        registerForm.isLoading = false;
                        NotificationsService.showSnackBar(errorMessage);
                      }
                    },
              color: AppTheme.primary,
              child: Text(registerForm.isLoading ? 'Espere' : 'Registrar',
                  style: TextStyle(
                      color: registerForm.isLoading
                          ? Colors.black
                          : Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
