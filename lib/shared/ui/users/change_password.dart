import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/shared/controllers/app_controller.dart';
import 'package:qubit_geo/shared/ui/pixabay/pixabay.dart';
import 'package:qubit_geo/shared/ui/scaffold/my_scaffold.dart';
import 'package:qubit_geo/shared/ui/users/forms/changepwdform.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.put(AppController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      appController.setAppBarState(
        'UserPWD',
        0xe3ae,
        true,
        true,
        false,
        false,
        true,
        false,
        0.0,
        0.45,
      );
    });
    return MyScaffold(
      left: Center(child: Text("Left")),
      main: Changepwdform(),
      right: Pixabay(),
      bottom: Center(child: Text("Bottom")),
    );
  }
}
