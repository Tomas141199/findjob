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
  const _HeaderLogo();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          margin: const EdgeInsets.only(top: 80),
          width: double.infinity,
          child: Column(
            children: const [
              Text(
                "FindJob",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 60,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
            ],
          )),
    );
  }
}
