import 'package:findjob_app/models/models.dart';
import 'package:flutter/material.dart';
import '../screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'login';

  static final screenOptions = <ScreenOption>[
    ScreenOption(
      route: 'home',
      name: 'Inicio',
      screen: const HomeScreen(),
      icon: Icons.login_rounded,
    ),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({'login': (BuildContext context) => const LoginScreen()});
    for (final screenOption in screenOptions) {
      appRoutes.addAll(
          {screenOption.route: (BuildContext context) => screenOption.screen});
    }

    return appRoutes;
  }
}
