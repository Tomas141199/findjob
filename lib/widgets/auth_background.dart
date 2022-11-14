import 'package:findjob_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppTheme.primary,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            const _HeaderLogo(),
            child,
          ],
        ));
  }
}

class _HeaderLogo extends StatelessWidget {
  const _HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
          width: double.infinity,
          height: 100,
          child: Column(
            children: const [
              
              Text(
                "FindJob",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );
  }
}
