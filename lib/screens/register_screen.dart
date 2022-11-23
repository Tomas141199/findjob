import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:findjob_app/providers/providers.dart';
import 'package:findjob_app/theme/app_theme.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: ListView(
          padding: const EdgeInsets.only(top: 30.0, right: 25.0, left: 25.0),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    'Formulario de registro',
                    style: AppTheme.subEncabezado,
                  ),
                ),
                ChangeNotifierProvider(
                  create: (_) => RegisterFormProvider(),
                  child: const RegisterForm(),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, "login"),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(const StadiumBorder()),
                  ),
                  child: const Text("¿Ya tienes una cuenta?, Entra"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
