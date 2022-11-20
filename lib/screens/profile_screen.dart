
import 'package:cached_network_image/cached_network_image.dart';
import 'package:findjob_app/screens/edituser_screen.dart';
import 'package:findjob_app/theme/app_theme.dart';
import 'package:findjob_app/widgets/arguments.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget{
  const ProfileScreen({Key? key}):super(key: key);

  @override
  _ProfileScreen createState()=>_ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen>{
  @override
  Widget build(BuildContext context){

    const String userName="Nombre del usuario";
    const String userObjetives="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse diam nisl, lobortis non tortor vel, mattis volutpat purus. Etiam tempor, nibh sit amet pulvinar volutpat, justo tortor iaculis dolor, et ultrices massa enim ut ante. Quisque facilisis, nulla at ultrices pretium, arcu ante vehicula orci, ";
    const String userEmail="example@outlock.com";
    const String userPhone="xxx-xxx-9999";
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding:EdgeInsets.only(left:20.0,right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              
              
                Container(
                  
                  margin: EdgeInsets.only(top: 20.0,bottom: 20.0,right:100.0,left: 100.0),
                  width: 200.0,
                  height: 200.0,
                  decoration: new BoxDecoration( 
                    shape: BoxShape.circle,
                    border: Border.all(color: Color.fromRGBO(13, 13, 13, 0.8), width: 2),
                  ),

                  child:CircleAvatar(
                    radius: 150,
                    backgroundColor: Color.fromRGBO(13, 13, 13, 0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(0), // Border radius
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(90), // Image radius
                          child: _profileImage(),
                        ),
                      ),
                    ),
                  ),
                  
                ),

              Text('$userName',
                style: AppTheme.subEncabezado,
              ),

              //Datos de usuario
              Padding(
                padding: EdgeInsets.only(top:20.0),
                child:Text('Aptitudes y objetivos',
                  style: AppTheme.subEncabezadoDos,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top:20.0),
                child:Text(
                  '$userObjetives',
                  style:AppTheme.datos,
                )
              ),
        
              //Información de contacto del usuario
              Padding(
                padding: EdgeInsets.only(top:20.0),
                child:Text('Información de contacto',
                  style: AppTheme.subEncabezadoDos,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top:20.0),
                child:RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.phone),
                      ),
                      TextSpan(
                        text: " "+userPhone,
                        style:AppTheme.datos,
                      ),
                    ],
                  ),
                )                
              ),

              Padding(
                padding: EdgeInsets.only(top:10.0),
                child:RichText(
                  text:TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.email_rounded),
                      ),
                      TextSpan(
                        text: " "+userEmail,
                        style:AppTheme.datos,
                      ),
                    ],
                  ),
                ),                
              ),

              //Verificación de los datos
              Padding(
                padding: EdgeInsets.only(top:20.0),
                child:Text('Verificación de datos',
                  style: AppTheme.subEncabezadoDos,
                ),
              ),

              //Carga de documentos
              Padding(
                padding: EdgeInsets.only(top:20.0),
                child:Text('Documentos',
                  style: AppTheme.subEncabezadoDos,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton:_edit(),

      ),
    );

  }


  //Foto de perfil del usuario
  Widget _profileImage(){
    return CachedNetworkImage(
      imageUrl: "http://via.placeholder.com/200x150",
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(  
          image: new DecorationImage(
            fit: BoxFit.fill,
            image: new NetworkImage("https://i.imgur.com/BoN9kdC.png"),
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => 
      CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }


  Widget _edit(){
    return FloatingActionButton(
      onPressed: () {
        // Add your onPressed code here!
         Navigator.pushNamed(
          context,'editarUsuario',arguments: WidgetArguments('modo','edición'),
        );
      },
      elevation: 4,
      child: const Icon(Icons.edit),
      backgroundColor: Color.fromRGBO(255, 39, 114, 1),
    );
  }

}