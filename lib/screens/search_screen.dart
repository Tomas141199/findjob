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
      body: Center(
        child: Text(
          'Interfaz de búsqueda',
        ),
      ),
    );
  }
}