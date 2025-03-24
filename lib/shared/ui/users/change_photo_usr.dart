import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/shared/controllers/app_controller.dart';
import 'package:qubit_geo/shared/ui/pixabay/pixabay.dart';
import 'package:qubit_geo/shared/ui/scaffold/my_scaffold.dart';
import 'package:qubit_geo/shared/ui/users/forms/changephotoform.dart';

class ChangePhotoUsr extends StatelessWidget {
  const ChangePhotoUsr({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.put(AppController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      appController.setAppBarState(
        'UserPhoto',
        0xe332,
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
      main: ChangePhotoForm(),
      right: Pixabay(),
      bottom: Center(child: Text("Bottom")),
    );
  }
}
