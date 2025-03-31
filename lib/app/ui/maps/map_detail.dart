import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:qubit_geo/app/controllers/geolocator_controller.dart';
import 'package:qubit_geo/shared/ui/users/useraction/circle_user.dart';

class MapDetail extends StatelessWidget {
  MapDetail({super.key});

  final MapController mapController = MapController();
  final GeolocatorController geolocatorController = Get.put(
    GeolocatorController(),
  );

  @override
  Widget build(BuildContext context) {
    everAll([geolocatorController.lat, geolocatorController.lng], (_) {
      print("se movió");
      mapController.move(
        LatLng(geolocatorController.lat.value, geolocatorController.lng.value),
        mapController.camera.zoom,
      );
    });

    ever(geolocatorController.setOriginFlag, (_) {
      mapController.move(
        LatLng(geolocatorController.lat.value, geolocatorController.lng.value),
        mapController.camera.zoom,
      );
      geolocatorController.setOriginFlag.value = false;
    });

    ever(geolocatorController.rotationFlag, (_) {
      mapController.moveAndRotate(
        mapController.camera.center,
        mapController.camera.zoom,
        0,
      );
      geolocatorController.rotationFlag.value = false;
    });

    ever(geolocatorController.zoomIn, (_) {
      mapController.move(
        mapController.camera.center,
        mapController.camera.zoom < 18 ? mapController.camera.zoom + 1 : 19,
      );
      geolocatorController.zoomIn.value = false;
    });

    ever(geolocatorController.zoomOut, (_) {
      mapController.move(
        mapController.camera.center,
        mapController.camera.zoom > 3 ? mapController.camera.zoom - 1 : 2,
      );
      geolocatorController.zoomOut.value = false;
    });

    return Obx(
      () => FlutterMap(
        mapController: mapController,
        options: MapOptions(initialCenter: LatLng(0, 0), initialZoom: 19),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(
                  geolocatorController.lat.value,
                  geolocatorController.lng.value,
                ),
                child: CircleUser(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
