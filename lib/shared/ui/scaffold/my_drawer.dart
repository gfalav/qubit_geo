import 'package:flutter/material.dart';
import 'package:qubit_geo/shared/ui/menu/main_menu.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(child: MainMenu());
  }
}
