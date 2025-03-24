import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/shared/controllers/app_controller.dart';

class MyBody extends StatelessWidget {
  final Widget left;
  final Widget main;
  final Widget right;
  final Widget bottom;
  const MyBody({
    super.key,
    required this.left,
    required this.main,
    required this.right,
    required this.bottom,
  });

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
                    color: ColorScheme.of(context).primaryContainer,
                    child: left,
                  ),
                  Container(
                    width:
                        appController.totalWidth.value *
                        (1 -
                            appController.leftPanelWidth.value -
                            appController.rightPanelWidth.value),
                    color: ColorScheme.of(context).secondaryContainer,
                    child: main,
                  ),
                  Container(
                    width:
                        appController.totalWidth.value *
                        appController.rightPanelWidth.value,
                    color: ColorScheme.of(context).tertiaryContainer,
                    child: right,
                  ),
                ],
              ),
            ),
            Container(
              width: appController.totalWidth.value,
              height: 48,
              color: ColorScheme.of(context).surfaceContainer,
              child: bottom,
            ),
          ],
        ),
      ),
    );
  }
}
