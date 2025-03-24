import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/shared/controllers/app_controller.dart';
import 'package:qubit_geo/shared/ui/scaffold/my_app_bar.dart';
import 'package:qubit_geo/shared/ui/scaffold/my_body.dart';
import 'package:qubit_geo/shared/ui/scaffold/my_drawer.dart';

class MyScaffold extends StatelessWidget {
  final Widget left;
  final Widget main;
  final Widget right;
  final Widget bottom;
  const MyScaffold({
    super.key,
    required this.left,
    required this.main,
    required this.right,
    required this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.put(AppController());
    appController.setTotalDimensions(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );

    return Obx(
      () => Scaffold(
        appBar:
            appController.appBarVisible.value
                ? MyAppBar().appBar(context)
                : null,
        drawer:
            appController.drawerVisible.value &&
                    appController.devType.value == 'Mobile'
                ? MyDrawer()
                : null,
        body: MyBody(left: left, main: main, right: right, bottom: bottom),
      ),
    );
  }
}
