import 'package:findjob_app/screens/loading_screen.dart';
import 'package:findjob_app/services/chat_service.dart';
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
    final chatService = Provider.of<ChatService>(context);
    final chatList = chatService.chats;

    if (chatService.isLoading) return const LoadingScreen();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F2EF),
      body: ListView.builder(
        itemCount: chatList.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          /*onTap: (){
            print(chatList[index].id);
          },*/
          child: WidgetItemChat(chatUser: chatList[index]),
        ),
      ),
    );
  }
}
