import 'package:findjob_app/theme/app_theme.dart';
import 'package:findjob_app/widgets/item_oferta.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget{
  const SearchScreen({Key? key}):super(key: key);

  @override
  _SearchScreen createState()=>_SearchScreen();
}

class _SearchScreen extends State<SearchScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      
      body:CustomScrollView(
        slivers:<Widget> [
          _listaItemOfertas(),
        ],
      ),  
    
    );
  }

  Widget _listaItemOfertas(){
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(3, (int index){
          return WidgetOferta();
        }
      ),
      ),
    );
  }
}

