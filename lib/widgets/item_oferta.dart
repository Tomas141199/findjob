import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class WidgetOferta extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    String puesto="Nombre del trabajo";
    String establecimiento="Establecimiento";
    String fecha="12/12/2022";
    String salario="0.0";
    return Card(

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    margin: EdgeInsets.only(right:10,left: 10,top: 5,bottom:5),
    elevation: 1,

    child: Column(
      children: <Widget>[

        ListTile(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          title: Text('$puesto',style: AppTheme.subEncabezadoDos),
          subtitle: Text(
              '$establecimiento \nPublicado- $fecha',style: AppTheme.datos,),
          leading:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.work, color: Colors.blueGrey,size: 32.0,),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Wrap(
                children: <Widget>[
                  Icon(Icons.attach_money_outlined), 
                  Text(salario,style: AppTheme.datos,),
                ],
              ),
            ],  
          ),
          
          
          //Icon(Icons.monetization_on)
          //Text('$salario')
        ),
        
      ],
    ),

    );
  }
}