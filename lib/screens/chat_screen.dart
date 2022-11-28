import 'package:findjob_app/models/job_solicitud.dart';
import 'package:findjob_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:findjob_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../models/widget_arguments.dart';
import '../services/jobs_service.dart';
import '../widgets/messages_chat.dart';

class ChatScreen extends StatelessWidget {
  
   const ChatScreen({super.key});
  
  @override
  Widget build(BuildContext context) {

    //En esta interfaz se tienen que conseguir los mensajes del usuario
    //var chatMessageService = Provider.of<ChatMessageService>(context);
    //var chatMessagesList = chatMessageService.chatMessages;
    final jobsService = Provider.of<JobsService>(context);

    final messagesService = Provider.of<ChatMessageService>(context);
    var chatMessagesList = messagesService.chatMessages;
    final args = ModalRoute.of(context)!.settings.arguments as WidgetArguments;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            HeaderChat(name:args.action!=2?jobsService.selectedJobSolicitud.nombreSolicitante:messagesService.chatSelected.usuario_destinatario, key: null,),
            Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),

                  child: ListView.builder(
                  itemCount: chatMessagesList.length,
                  itemBuilder: (BuildContext context, int index) => GestureDetector(
                    
                    child: MessageWidget(message: chatMessagesList[index],isMe:chatMessagesList[index].idUser==messagesService.idUsuarioActual?true:false),
                    ),
                  ),
                ),
              ),
            FooterNewMessage(action:args.action),
          ],
        ),
      ),
    );
  }
}
