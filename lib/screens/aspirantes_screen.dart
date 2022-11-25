import 'package:findjob_app/theme/app_theme.dart';
import 'package:flutter/material.dart';


class AspirantesScreen extends StatelessWidget {
  const AspirantesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      appBar: AppBar(
        elevation: 0,
        title: const Text("FindJob",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(255, 252, 252, 1),
              fontSize: 25.0,
              fontWeight: FontWeight.w800,
              fontFamily: 'OpenSans',
            )),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 252, 252, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        
      ),
    );
  }
}

