import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget{
  const ProfileScreen({Key? key}):super(key: key);

  @override
  _ProfileScreen createState()=>_ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Text(
          'Interfaz del perfil',
        ),
      ),
    );
  }
}