import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/shared/controllers/app_controller.dart';

class MyAppBar {
  PreferredSizeWidget appBar(BuildContext context) {
    final AppController appController = Get.put(AppController());

    return AppBar(
      title: Obx(
        () => Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 6),
              child: Icon(
                IconData(
                  appController.appBarIcon.value,
                  fontFamily: 'MaterialIcons',
                ),
              ),
            ),
            Text(
              appController.appBarTitle.value,
              style: TextStyle(fontSize: 19),
            ),
          ],
        ),
      ),
      backgroundColor: ColorScheme.of(context).primary,
      actions: [],
    );
  }
}
