import 'package:findjob_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  _MessagesScreen createState() => _MessagesScreen();
}

class _MessagesScreen extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.backgroundRounded,
      child: Center(
        child: Text(
          'Interfaz de Mensajes',
        ),
      ),
    );
  }
}
