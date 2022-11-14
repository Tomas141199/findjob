import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget{
  const MessagesScreen({Key? key}):super(key: key);

  @override
  _MessagesScreen createState()=>_MessagesScreen();
}

class _MessagesScreen extends State<MessagesScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Text(
          'Interfaz de Mensajes',
        ),
      ),
    );
  }
}