import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:qubit_geo/app/controllers/geolocator_controller.dart';
import 'package:qubit_geo/shared/ui/users/useraction/circle_user.dart';

class Mapa extends StatelessWidget {
  const Mapa({super.key});

  @override
  Widget build(BuildContext context) {
    final MapController mapController = MapController();
    final GeolocatorController geolocatorController = Get.put(
      GeolocatorController(),
    );

    final zoomLevel = 19.0;

    everAll([geolocatorController.lat, geolocatorController.lng], (_) {
      mapController.move(
        LatLng(geolocatorController.lat.value, geolocatorController.lng.value),
        zoomLevel,
      );
    });

    return Obx(
      () => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            mapController.move(
              LatLng(
                geolocatorController.lat.value,
                geolocatorController.lng.value,
              ),
              zoomLevel,
            );
          },
          child: Icon(Icons.my_location),
        ),
        body: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: LatLng(0, 0),
            initialZoom: zoomLevel,
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
      ),
    );
  }
}
