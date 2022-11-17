import 'package:findjob_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreen createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.backgroundRounded,
      child: const Center(
        child: Text("Search screen"),
      ),
    );
  }
}
