import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/app/controllers/geolocator_controller.dart';
import 'package:qubit_geo/app/ui/maps/map_detail.dart';
import 'package:qubit_geo/shared/controllers/app_controller.dart';
import 'package:qubit_geo/shared/ui/menu/main_menu.dart';
import 'package:qubit_geo/shared/ui/scaffold/my_scaffold.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.put(AppController());
    final GeolocatorController geolocatorController = Get.put(
      GeolocatorController(),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      appController.setAppBarState(
        'MapView',
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
      main: MapDetail(),
      right: Center(child: Text("Right")),
      bottom: Center(child: Text("Bottom")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          geolocatorController.flagUpdate.value =
              !geolocatorController.flagUpdate.value;
        },
        child: Icon(Icons.my_location),
      ),
    );
  }
}
