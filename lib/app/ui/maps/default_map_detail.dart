import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:qubit_geo/app/controllers/default_map_controller.dart';
import 'package:qubit_geo/app/controllers/geolocator_controller.dart';

class DefaultMapDetail extends StatelessWidget {
  const DefaultMapDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final DefaultMapController defaultMapController = Get.put(
      DefaultMapController(),
    );
    final GeolocatorController geolocatorController = Get.put(
      GeolocatorController(),
    );

    return Obx(
      () => FlutterMap(
        options: MapOptions(),
        mapController: defaultMapController.mapController,
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(
                  geolocatorController.lat.value,
                  geolocatorController.long.value,
                ),
                child: Icon(Icons.location_pin),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
