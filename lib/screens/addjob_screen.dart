import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AddJobScreen extends StatefulWidget{
  const AddJobScreen({Key? key}):super(key: key);

  @override
  _AddJobScreen createState()=>_AddJobScreen();
}

class _AddJobScreen extends State<AddJobScreen>{

  final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(4, 135, 217, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(4, 135, 217, 1),
          elevation: 0,
          /*title: const Text(
            "Crear oferta laboral",
            textAlign: TextAlign.right,
            style:TextStyle(
              color:Color.fromRGBO(255, 252, 252, 1),
              fontSize:16.0,
              fontWeight: FontWeight.bold,
              fontFamily:'Arial',
            )
          ),*/
        ),
          body: SafeArea(

        child:SingleChildScrollView(
            child: Container(
            padding: EdgeInsets.only(top:30.0,right: 25.0,left: 25.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 252, 252, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),

            child:Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Registrar oferta laboral',
                  style: AppTheme.subEncabezado,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                   child:_FormularioRegistro(context),
                ),  
                
              ],
            ),  

            
          ),
          ),
        ),
      ),
    );
  }

  Widget _FormularioRegistro(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top:10.0),
            child: TextFormField(
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),

              //Decoración del elemento
              decoration: InputDecoration(
                labelText: 'Establecimiento',
                prefixIcon: Icon(Icons.maps_home_work),
                contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                
                enabledBorder:AppTheme.lightTheme.inputDecorationTheme.enabledBorder,
                focusedBorder:AppTheme.lightTheme.inputDecorationTheme.focusedBorder,
              ),
            ),
          ),
         Padding(
            padding: EdgeInsets.only(top:20.0),
            child: TextFormField(
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),

              //Decoración del textFormField
              decoration: InputDecoration(
                labelText: 'Ubicación',
                prefixIcon: Icon(Icons.place),
                //suffixIcon: Icon(Icons.eyes),
                contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                
                enabledBorder:AppTheme.lightTheme.inputDecorationTheme.enabledBorder,
                focusedBorder:AppTheme.lightTheme.inputDecorationTheme.focusedBorder,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:20.0),
            child: TextFormField(
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),

              //Decoración del input
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: 'Puesto requerido',
                contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                
                enabledBorder:AppTheme.lightTheme.inputDecorationTheme.enabledBorder,
                focusedBorder:AppTheme.lightTheme.inputDecorationTheme.focusedBorder,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top:20.0),
            child: TextFormField(
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),

              //Decoración del textFormField
              decoration: InputDecoration(
                labelText: 'Sueldo',
                prefixIcon: Icon(Icons.monetization_on),
                //suffixIcon: Icon(Icons.eyes),
                contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                
                enabledBorder:AppTheme.lightTheme.inputDecorationTheme.enabledBorder,
                focusedBorder:AppTheme.lightTheme.inputDecorationTheme.focusedBorder,
              ),
            ),
          ),
          //Sección de la descripción del empleo
          Padding(
            padding: EdgeInsets.only(top:20.0),
            child: TextFormField(
              maxLines: 4, //or null 
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),

              //Decoración del textFormField
              decoration: InputDecoration(
                labelText: 'Descripción del empleo',
                contentPadding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                
                enabledBorder:AppTheme.lightTheme.inputDecorationTheme.enabledBorder,
                focusedBorder:AppTheme.lightTheme.inputDecorationTheme.focusedBorder,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:30.0,bottom:30.0),
            child:MaterialButton(
            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            height: 50.0,
              onPressed: () {
                
              },
              color: Color.fromRGBO(0, 77, 133, 1),
              child: Text(
                'Publicar',
                style: TextStyle(
                color: Colors.white
              )
            ),
          ),   
          ),
        ],
      ),
    );
  }
}