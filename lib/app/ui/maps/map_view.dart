import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/app/controllers/my_map_controller.dart';
import 'package:qubit_geo/app/ui/maps/map_detail.dart';
import 'package:qubit_geo/shared/controllers/app_controller.dart';
import 'package:qubit_geo/shared/controllers/geolocator_controller.dart';
import 'package:qubit_geo/shared/ui/menu/main_menu.dart';
import 'package:qubit_geo/shared/ui/scaffold/my_scaffold.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.put(AppController());
    final MyMapController myMapController = Get.put(MyMapController());
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
      floatingActionButton: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Switch(
                value: geolocatorController.recordPositionEnabled.value,
                onChanged: (event) {
                  geolocatorController.recordPositionEnabled.value = event;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: FloatingActionButton(
                heroTag: 'getPoints',
                onPressed: () {
                  myMapController.getPoints();
                },
                child: Icon(Icons.history),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: FloatingActionButton(
                heroTag: 'rotation',
                onPressed: () {
                  myMapController.rotationFlag.value = true;
                },
                child: Icon(Icons.explore),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: FloatingActionButton(
                heroTag: 'zoomIn',
                onPressed: () {
                  myMapController.zoomIn.value = true;
                },
                child: Icon(Icons.zoom_in),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: FloatingActionButton(
                heroTag: 'zoomOut',
                onPressed: () {
                  myMapController.zoomOut.value = true;
                },
                child: Icon(Icons.zoom_out),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: FloatingActionButton(
                heroTag: 'center',
                onPressed: () {
                  myMapController.setOriginFlag.value =
                      !myMapController.setOriginFlag.value;
                },
                child: Icon(Icons.my_location),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
