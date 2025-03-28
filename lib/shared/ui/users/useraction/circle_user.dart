import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/shared/controllers/user_controller.dart';

class CircleUser extends StatelessWidget {
  CircleUser({super.key});

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CircleAvatar(
        backgroundColor: ColorScheme.of(context).tertiary,
        backgroundImage:
            userController.photoURL.value != ''
                ? Image.network(userController.photoURL.value).image
                : null,
        child:
            userController.photoURL.value == ''
                ? Text(
                  userController.initials.value,
                  style: TextStyle(color: Colors.white),
                )
                : null,
      ),
    );
  }
}
