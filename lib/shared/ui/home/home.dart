import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/shared/controllers/app_controller.dart';
import 'package:qubit_geo/shared/ui/scaffold/my_scaffold.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.put(AppController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      appController.setAppBarState(
        'Home',
        0xe318,
        true,
        true,
        true,
        true,
        true,
        true,
        0.3,
        0.3,
      );
    });
    return MyScaffold(
      left: Center(child: Text("Left")),
      main: Center(child: Text("Main")),
      right: Center(child: Text("Right")),
      bottom: Center(child: Text("Bottom")),
    );
  }
}
