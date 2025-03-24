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
      () => Container(
        color: ColorScheme.of(context).secondaryContainer,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible:
                          appController.leftPanelVisible.value &&
                          appController.devType.value != 'Mobile',
                      child: Container(
                        width:
                            appController.totalWidth.value *
                            appController.leftPanelWidth.value,
                        color: ColorScheme.of(context).primaryContainer,
                        child: left,
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        width:
                            appController.devType.value != 'Mobile'
                                ? appController.totalWidth.value *
                                    (1 -
                                        appController.leftPanelWidth.value -
                                        appController.rightPanelWidth.value)
                                : appController.totalWidth.value,
                        color: ColorScheme.of(context).secondaryContainer,
                        child: main,
                      ),
                    ),
                    Visibility(
                      visible:
                          appController.rightPanelVisible.value &&
                          appController.devType.value != 'Mobile',
                      child: Container(
                        width:
                            appController.totalWidth.value *
                            appController.rightPanelWidth.value,
                        color: ColorScheme.of(context).secondaryContainer,
                        child: right,
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: appController.bottomPanelVisible.value,
                child: Container(
                  width: appController.totalWidth.value,
                  height: 48,
                  color: ColorScheme.of(context).surfaceContainer,
                  child: bottom,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
