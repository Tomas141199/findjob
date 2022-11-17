import 'package:findjob_app/theme/app_theme.dart';
import 'package:findjob_app/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class EditionScreen extends StatelessWidget {
  const EditionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(4, 135, 217, 1),
        elevation: 0,
        title: const Text("FindJob",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(255, 252, 252, 1),
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Arial',
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    'Formulario de edición',
                    style: AppTheme.subEncabezado,
                  ),
                ),
                ChangeNotifierProvider(
                  create: (_) => RegisterFormProvider(),
                  child: const RegisterForm(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
