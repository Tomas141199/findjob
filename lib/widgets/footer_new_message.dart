import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';


class FooterNewMessage extends StatefulWidget {
  final int action;
  const FooterNewMessage({Key? key, required this.action}) : super(key: key);

  @override
  _FooterNewMessage createState() => _FooterNewMessage();
}

class _FooterNewMessage extends State<FooterNewMessage>{
  final _controller=TextEditingController();
  String message="";  
  @override
  Widget build(BuildContext context){

    final jobService = Provider.of<JobsService>(context);

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
                
                if(widget.action!=2)
                  chatMessageService.crearMensaje(jobService.selectedJobSolicitud,message);     
                else
                  chatMessageService.crearMensajeDos(chatMessageService.chatSelected,message);     
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