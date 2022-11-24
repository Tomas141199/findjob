import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../services/chat_message_service.dart';

class NewMessageWidget extends StatefulWidget {
  
  const NewMessageWidget({Key? key}) : super(key: key);

  @override
  _NewMessageWidget createState() => _NewMessageWidget();
}

class _NewMessageWidget extends State<NewMessageWidget>{
  final _controller=TextEditingController();
  String message="";  
  @override
  Widget build(BuildContext context){

    final chatMessageService = Provider.of<ChatMessageService>(context);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                labelText: "Escribe un mensaje",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(width: 0),
                  gapPadding: 10,
                ),
              ),
              onChanged: (value) => setState(() {
                 message=value;
              }),
            ),
          ),
          SizedBox(width: 20),
          GestureDetector(
            onTap: (){
              if(message.trim().isEmpty){
                null;
              }else{
                DateTime now = DateTime.now();
                String fecha = new DateFormat('EEE d MMM').format(now);
                String hora = new DateFormat('kk:mm:ss').format(now);

                chatMessageService.crearMensaje(fecha,hora, "usu-1", message);     
                _controller.clear(); 
              }
            },
           child:Container(padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue
            ),
            child: Icon(Icons.send, color: Colors.white,),
          ) 
          ),
                     
        ],
      ),
    );
  }
}