import 'package:findjob_app/screens/loading_screen.dart';
import 'package:findjob_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';

class ChatScreen extends StatelessWidget {
  
   String nombreUser;

   ChatScreen({super.key, required this.nombreUser});
  
  @override
  Widget build(BuildContext context) {

    //En esta interfaz se tienen que conseguir los mensajes del usuario
    var chatMessageService = Provider.of<ChatMessageService>(context);
    var chatMessagesList = chatMessageService.chatMessages;

    //if (chatMessageService.isLoading) return const LoadingScreen();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            ChatHeaderWidget(name:nombreUser, key: null,),
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
                  //child: MessagesWidget(idUser: widget.user.idUser),
                  
                  
                  child: ListView.builder(
                  itemCount: chatMessagesList.length,
                  itemBuilder: (BuildContext context, int index) => GestureDetector(
                    child: MessageWidget(message: chatMessagesList[index],isMe:chatMessagesList[index].idUser=="usu-1"?true:false),
                  ),
                  ),

                ),
              ),
            NewMessageWidget(),
          ],
        ),
      ),
    );
  }
}