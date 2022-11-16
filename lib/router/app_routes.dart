import 'package:findjob_app/models/models.dart';
import 'package:findjob_app/screens/addjob_screen.dart';
import 'package:findjob_app/screens/edituser_screen.dart';
import 'package:findjob_app/screens/profile_screen.dart';
import 'package:findjob_app/screens/registration_screen.dart';
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
    appRoutes.addAll({
      'login': (BuildContext context) => const LoginScreen(),
      'editarUsuario': (BuildContext context) => const EditionScreen(),
      'agregarUsuario': (BuildContext context) => const RegistrationScreen(),
      'agregarOferta': (BuildContext context) => const AddJobScreen(),

      });
    for (final screenOption in screenOptions) {
      appRoutes.addAll(
          {screenOption.route: (BuildContext context) => screenOption.screen});
    }

    return appRoutes;
  }
}
