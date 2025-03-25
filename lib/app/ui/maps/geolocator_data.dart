import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/app/controllers/geolocator_controller.dart';
import 'package:qubit_geo/shared/controllers/app_controller.dart';
import 'package:qubit_geo/shared/ui/menu/main_menu.dart';
import 'package:qubit_geo/shared/ui/scaffold/my_scaffold.dart';

class GeolocatorData extends StatelessWidget {
  const GeolocatorData({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.put(AppController());
    final GeolocatorController geolocatorController = Get.put(
      GeolocatorController(),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      appController.setAppBarState(
        'Geolocator',
        0xe318,
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
    return Obx(
      () => MyScaffold(
        left: MainMenu(),
        main: Center(
          child: Text(
            "Latitude: ${geolocatorController.lat.value}, Longitude: ${geolocatorController.lon.value}, Accuracy: ${geolocatorController.accuracy.value}",
          ),
        ),
        right: Center(child: Text("Right")),
        bottom: Center(child: Text("Bottom")),
      ),
    );
  }
}
