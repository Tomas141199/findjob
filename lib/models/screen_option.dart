import 'package:flutter/material.dart' show Icons, IconData, Widget;

class ScreenOption {
  final String route;
  final IconData icon;
  final String name;
  final Widget screen;

  ScreenOption(
      {required this.route,
      this.icon = Icons.device_unknown,
      required this.name,
      required this.screen});
}
