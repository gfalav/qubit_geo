import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:qubit_geo/app/controllers/geolocator_controller.dart';

class DefaultMapController extends GetxController {
  MapController mapController = MapController();
  GeolocatorController geolocatorController = Get.put(GeolocatorController());

  void moveUserPosition() {
    mapController.move(
      LatLng(geolocatorController.lat.value, geolocatorController.long.value),
      16,
    );
  }
}
