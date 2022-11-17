import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../theme/app_theme.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 0,
      unselectedFontSize: 0,
      iconSize: 24,
      elevation: 1,
      backgroundColor: AppTheme.whiteApp,
      selectedIconTheme: const IconThemeData(size: 28),
      selectedItemColor: AppTheme.deepBlue,
      unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
      selectedLabelStyle: Theme.of(context)
          .textTheme
          .bodyText1
          ?.merge(const TextStyle(color: Colors.white, fontSize: 12)),
      unselectedLabelStyle: Theme.of(context)
          .textTheme
          .button
          ?.merge(const TextStyle(color: Colors.white, fontSize: 11)),
      showUnselectedLabels: true,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work),
          label: 'Empleos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Mensajes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
      onTap: (index) => uiProvider.selectedMenuOpt = index,
    );
  }
}
