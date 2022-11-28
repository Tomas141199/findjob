import 'package:findjob_app/screens/screens.dart';
import 'package:findjob_app/search/search_delegate.dart';
import 'package:findjob_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      backgroundColor: AppTheme.primary,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.logout_sharp),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
        actions: [
          IconButton(
            onPressed: () =>
                showSearch(context: context, delegate: JobSearchDelegate()),
            icon: const Icon(Icons.search_rounded),
          )
        ],
        title: const Text("FindJob",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(255, 252, 252, 1),
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            )),
        centerTitle: true,
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    switch (currentIndex) {
      case 0:
        return const SearchScreen();
      case 1:
        return const JobsScreen();
      case 2:
        return const MessagesScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const LoginScreen();
    }
  }
}
