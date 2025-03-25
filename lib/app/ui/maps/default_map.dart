import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/app/controllers/default_map_controller.dart';
import 'package:qubit_geo/app/ui/maps/default_map_detail.dart';
import 'package:qubit_geo/shared/controllers/app_controller.dart';
import 'package:qubit_geo/shared/ui/menu/main_menu.dart';
import 'package:qubit_geo/shared/ui/scaffold/my_scaffold.dart';

class DefaultMap extends StatelessWidget {
  const DefaultMap({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.put(AppController());
    final DefaultMapController defaultMapController = Get.put(
      DefaultMapController(),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      appController.setAppBarState(
        'Mapa',
        0xe366,
        true,
        true,
        true,
        true,
        false,
        false,
        290 / appController.totalWidth.value,
        0.0,
      );
    });
    return MyScaffold(
      left: MainMenu(),
      main: DefaultMapDetail(),
      right: Center(child: Text("Right")),
      bottom: SizedBox(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          defaultMapController.moveUserPosition();
        },
        child: Icon(Icons.my_location),
      ),
    );
  }
}
