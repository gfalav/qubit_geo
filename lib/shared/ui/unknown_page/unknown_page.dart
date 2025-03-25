import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/shared/controllers/app_controller.dart';
import 'package:qubit_geo/shared/ui/scaffold/my_scaffold.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.put(AppController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      appController.setAppBarState(
        'Error!!',
        0xe318,
        false,
        true,
        true,
        false,
        false,
        false,
        0.0,
        0.0,
      );
    });
    return MyScaffold(
      left: SizedBox(),
      main: Center(child: Text("Error - Page not found")),
      right: SizedBox(),
      bottom: SizedBox(),
    );
  }
}
