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
    double zoomLevel = 19.0;

    everAll([geolocatorController.lat, geolocatorController.lng], (_) {
      mapController.move(
        LatLng(geolocatorController.lat.value, geolocatorController.lng.value),
        zoomLevel,
      );
    });

    ever(geolocatorController.flagUpdate, (_) {
      mapController.move(
        LatLng(geolocatorController.lat.value, geolocatorController.lng.value),
        zoomLevel,
      );
      geolocatorController.flagUpdate.value = false;
    });

    return Obx(
      () => FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: LatLng(0, 0),
          initialZoom: zoomLevel,
          onPositionChanged: (camera, hasGesture) {
            zoomLevel = camera.zoom;
          },
        ),
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
