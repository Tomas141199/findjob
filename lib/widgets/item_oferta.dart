import 'package:flutter/material.dart';

class WidgetOferta extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Card(

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    margin: EdgeInsets.all(15),
    elevation: 5,

    child: Column(
      children: <Widget>[

        ListTile(
          contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
          title: Text('Titulo'),
          subtitle: Text(
              'Este es el subtitulo del card. Aqui podemos colocar descripción de este card.'),
          leading: Icon(Icons.home),
        ),
        
      ],
    ),

    );
  }
}