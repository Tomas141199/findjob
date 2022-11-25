import 'package:findjob_app/models/models.dart';
import 'package:flutter/material.dart';
import '../screens/jobs_data.dart';
import '../screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'checking';

  static final screenOptions = <ScreenOption>[
    ScreenOption(
      route: 'login',
      name: 'Login',
      screen: const LoginScreen(),
      icon: Icons.login_rounded,
    ),
    ScreenOption(
      route: 'home',
      name: 'Inicio',
      screen: const HomeScreen(),
      icon: Icons.home,
    ),
    ScreenOption(
      route: 'registro',
      name: 'Registro',
      screen: const RegisterScreen(),
      icon: Icons.app_registration,
    ),
    ScreenOption(
      route: 'registro',
      name: 'Registro',
      screen: const RegisterScreen(),
      icon: Icons.app_registration,
    ),
    ScreenOption(
      route: 'editarUsuario',
      name: 'Editar',
      screen: const EditionScreen(),
      icon: Icons.edit,
    ),
    ScreenOption(
      route: 'agregarOferta',
      name: 'Agregar',
      screen: const AddJobScreen(),
      icon: Icons.add,
    ),
    ScreenOption(
      route: 'verOferta',
      name: 'visualizar',
      screen: const JobsData(),
      icon: Icons.add,
    ),
    ScreenOption(
      route: 'aspirantes',
      name: 'verAspirantes',
      screen: const AspirantesScreen(),
      icon: Icons.add,
    ),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({
      'checking': (BuildContext context) => const CheckAuthScreen(),
    });
    for (final screenOption in screenOptions) {
      appRoutes.addAll(
          {screenOption.route: (BuildContext context) => screenOption.screen});
    }

    return appRoutes;
  }
}
