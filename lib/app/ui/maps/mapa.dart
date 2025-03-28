import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:qubit_geo/app/controllers/geolocator_controller.dart';

class Mapa extends StatelessWidget {
  Mapa({super.key});

  final MapController mapController = MapController();
  final GeolocatorController geolocatorController = Get.put(
    GeolocatorController(),
  );
  final List<Marker> markers = [];
  final zoomLevel = 19.0;

  @override
  Widget build(BuildContext context) {
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
                  child: Icon(Icons.location_pin),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
