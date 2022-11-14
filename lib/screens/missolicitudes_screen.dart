import 'package:flutter/material.dart';

class MisSolicitudesScreen extends StatefulWidget{
  const MisSolicitudesScreen({Key? key}):super(key: key);

  @override
  _MisSolicitudesScreen createState()=>_MisSolicitudesScreen();
}

class _MisSolicitudesScreen extends State<MisSolicitudesScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Text(
          'Interfaz de mis solicitudes',
        ),
      ),
    );
  }
}