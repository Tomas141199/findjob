import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:findjob_app/providers/providers.dart';
import 'package:findjob_app/router/app_routes.dart';
import 'package:findjob_app/services/services.dart';
import 'package:findjob_app/theme/app_theme.dart';

void main() {
  runApp( AppState());
}

class AppState extends StatelessWidget {
   AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => JobsService()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: NotificationsService.messengerKey,
      title: 'FindJob',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.getAppRoutes(),
      theme: AppTheme.lightTheme,
    );
  }
}
