import 'package:findjob_app/theme/app_theme.dart';
import 'package:findjob_app/widgets/registration_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class EditionScreen extends StatelessWidget{

  const EditionScreen({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(4, 135, 217, 1),
            elevation: 0,
          centerTitle: true,
        ), 
        body: Container(
          padding: EdgeInsets.only(top:10.0,bottom: 10.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 252, 252, 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),

          child:ListView(

            padding: EdgeInsets.only(top:30.0,right: 25.0,left: 25.0),
            children: <Widget> [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(bottom: 20.0),
                    child: Text('Formulario de edición',
                      style: AppTheme.subEncabezado,
                    ),
                  ),
                  RegistrationForm(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}