import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/shared/controllers/app_controller.dart';

class MyBody extends StatelessWidget {
  const MyBody({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.put(AppController());

    return Obx(
      () => SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width:
                        appController.totalWidth.value *
                        appController.leftPanelWidth.value,
                    color: Colors.amber,
                    child: Text("Izquierda"),
                  ),
                  Container(
                    width:
                        appController.totalWidth.value *
                        (1 -
                            appController.leftPanelWidth.value -
                            appController.rightPanelWidth.value),
                    color: Colors.green,
                    child: Text("Centro"),
                  ),
                  Container(
                    width:
                        appController.totalWidth.value *
                        appController.rightPanelWidth.value,
                    color: Colors.cyan,
                    child: Text("Derecha"),
                  ),
                ],
              ),
            ),
            Container(
              width: appController.totalWidth.value,
              height: 48,
              color: Colors.blue,
              child: Text("Abajo"),
            ),
          ],
        ),
      ),
    );
  }
}
