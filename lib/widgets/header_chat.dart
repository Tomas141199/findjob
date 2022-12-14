import 'package:flutter/material.dart';

class HeaderChat extends StatelessWidget {
  final String name;

  const HeaderChat({
    required this.name,
     Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    height: 80,
    padding: EdgeInsets.all(16).copyWith(left: 0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BackButton(color: Colors.white),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 4),
          ],
        )
      ],
    ),
  );
 
}