import 'package:findjob_app/screens/addjob_screen.dart';
import 'package:flutter/material.dart';

class MyJobsScreen extends StatefulWidget{
  const MyJobsScreen({Key? key}):super(key: key);

  @override
  _MyJobsScreen createState()=>_MyJobsScreen();
}

class _MyJobsScreen extends State<MyJobsScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Text(
          'Interfaz de mis ofertas',
        ),
      ),
      

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
           Navigator.pushNamed(
            context,'agregarOferta'
          );
        },
        elevation: 4,
        child: const Icon(Icons.add),
        backgroundColor: Color.fromRGBO(255, 39, 114, 1),
      ),
    );
  }
}