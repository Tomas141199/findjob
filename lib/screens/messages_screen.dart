import 'package:findjob_app/models/models.dart';
import 'package:findjob_app/services/services.dart';
import 'package:findjob_app/theme/app_theme.dart';
import 'package:findjob_app/widgets/item_chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  _MessagesScreen createState() => _MessagesScreen();
}

class _MessagesScreen extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {

    final chatService = Provider.of<ChatMessageService>(context);
    final List<ChatUser> chats = chatService.chats;

   return Scaffold(
    
     body: chats.length>0? ListView.builder(
      
        itemCount: chats.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () async{
            chatService.chatSelected = chats[index].copy();
             print(chatService.chatSelected.id);
            print(chatService.chatSelected.usuario_destinatario);
            print(chatService.chatSelected.ultimo_mensaje);
            print(chatService.chatSelected.fecha);

            //Cargamos los mensajes
            await chatService.loadChatMessages();
            Navigator.pushNamed(context, 'chatScreen',arguments: WidgetArguments(edit: true,action: 2) );
          },
          child: ItemChat(chat: chats[index]),
        ),
      ):_emptyContainer(),
   );
  }

  Widget _emptyContainer() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.error_outline,
            color: Colors.black38,
            size: 130,
          ),
          Text(
            "Sin chats disponibles",
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
   }
}
