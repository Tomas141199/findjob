import 'package:findjob_app/models/models.dart';
import 'package:findjob_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class WidgetItemChat extends StatelessWidget{

  final ChatUser chatUser;
  const WidgetItemChat({super.key, required this.chatUser});
  
  @override
  Widget build(BuildContext context){

    
    return Card(

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    margin: EdgeInsets.only(right:0,left: 0,top: 2,bottom:2),
    elevation: 0,

    child: new InkWell(
      onTap: () {
        print(chatUser.usuario);
        Navigator.push(
          context,
              MaterialPageRoute(builder: (context) => ChatScreen(nombreUser:chatUser.usuario)),
        );
      },

      child:Column(
      children: <Widget>[
        ListTile(
          title: Text(overflow: TextOverflow.ellipsis,chatUser.usuario,style: AppTheme.subEncabezadoDos),
          subtitle: Text(
              overflow: TextOverflow.ellipsis,
              chatUser.ultimoMensaje,style: AppTheme.datos,),
          leading:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(
                      top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
                  width: 43.0,
                  height: 43.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 150,
                    backgroundColor: const Color.fromRGBO(13, 13, 13, 0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(0), // Border radius
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(90), // Image radius
                          child:Icon(Icons.person, color: Colors.white,size: 32.0,),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          trailing:Icon(Icons.more_vert, color: Colors.blueGrey,size: 24.0,),
        ),
      ],
    ),
    ),
    );
  }
}