import 'package:findjob_app/models/models.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;

  const MessageWidget({
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(12);
    final borderRadius = BorderRadius.all(radius);

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
      
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
          constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
          decoration: BoxDecoration(
            color: isMe ? Colors.black12 : Theme.of(context).accentColor,
            borderRadius: isMe
                ? borderRadius.subtract(BorderRadius.only(bottomRight: radius))
                : borderRadius.subtract(BorderRadius.only(bottomLeft: radius)),
          ),
          child: buildMessage(),
        ),
      ],
    );
  }

  Widget buildMessage() => Column(
    crossAxisAlignment:
    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: <Widget>[
    Text(
      message.mensaje,
      style: TextStyle(color: isMe ? Colors.black : Colors.white),
      textAlign: isMe ? TextAlign.end : TextAlign.start,
      ),
    ],
  );
}