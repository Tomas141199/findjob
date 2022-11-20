import 'package:findjob_app/screens/addjob_screen.dart';
import 'package:findjob_app/widgets/item_oferta_dos.dart';
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
      body:CustomScrollView(
        slivers:<Widget> [
          _listaItemMisOfertas(),
        ],
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

  Widget _listaItemMisOfertas(){
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(3, (int index){
          return WidgetOfertaDos();
        }
      ),
      ),
    );
  }
}