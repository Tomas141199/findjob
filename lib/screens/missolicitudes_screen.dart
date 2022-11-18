import 'package:findjob_app/widgets/item_oferta_tres.dart';
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
      body:CustomScrollView(
        slivers:<Widget> [
          _listaItemMisSolicitudes(),
        ],
      ),  
    );
  }

  Widget _listaItemMisSolicitudes(){
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(3, (int index){
          return WidgetOfertaTres();
        }
      ),
      ),
    );
  }
}