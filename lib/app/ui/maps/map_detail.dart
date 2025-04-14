import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:qubit_geo/app/controllers/my_map_controller.dart';
import 'package:qubit_geo/shared/controllers/geolocator_controller.dart';

class MapDetail extends StatelessWidget {
  const MapDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final MapController mapController = MapController();
    final MyMapController myMapController = Get.put(MyMapController());
    final GeolocatorController geolocatorController = Get.put(
      GeolocatorController(),
    );

    everAll([geolocatorController.lat, geolocatorController.lng], (_) {
      mapController.move(
        LatLng(geolocatorController.lat.value, geolocatorController.lng.value),
        mapController.camera.zoom,
      );
    });

    ever(myMapController.setOriginFlag, (_) {
      mapController.move(
        LatLng(geolocatorController.lat.value, geolocatorController.lng.value),
        mapController.camera.zoom,
      );
      myMapController.setOriginFlag.value = false;
    });

    ever(myMapController.rotationFlag, (_) {
      mapController.moveAndRotate(
        mapController.camera.center,
        mapController.camera.zoom,
        0,
      );
      myMapController.rotationFlag.value = false;
    });

    ever(myMapController.zoomIn, (_) {
      mapController.move(
        mapController.camera.center,
        mapController.camera.zoom < 18 ? mapController.camera.zoom + 1 : 19,
      );
      myMapController.zoomIn.value = false;
    });

    ever(myMapController.zoomOut, (_) {
      mapController.move(
        mapController.camera.center,
        mapController.camera.zoom > 3 ? mapController.camera.zoom - 1 : 2,
      );
      myMapController.zoomOut.value = false;
    });

    geolocatorController.getPosition();

    return Obx(
      () => FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: LatLng(
            geolocatorController.lat.value,
            geolocatorController.lng.value,
          ),
          initialZoom: 19,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(markers: myMapController.markers),
          PolylineLayer(
            polylines: [
              Polyline(
                points:
                    myMapController.points.isNotEmpty
                        ? myMapController.points
                        : [
                          LatLng(
                            geolocatorController.lat.value,
                            geolocatorController.lng.value,
                          ),
                        ],
                color: Colors.red,
                strokeWidth: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
