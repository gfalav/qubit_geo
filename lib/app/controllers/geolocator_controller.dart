import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GeolocatorController extends GetxController {
  final lat = 0.0.obs;
  final lon = 0.0.obs;
  final accuracy = 0.0.obs;
  final altitude = 0.0.obs;
  final speed = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getLocation();
  }

  void setLocation(
    double lat,
    double lon,
    double accuracy,
    double altitude,
    double speed,
  ) {
    this.lat.value = lat;
    this.lon.value = lon;
    this.accuracy.value = accuracy;
    this.altitude.value = altitude;
    this.speed.value = speed;
  }

  void getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    Position position;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    position = await Geolocator.getCurrentPosition();
    setLocation(
      position.latitude,
      position.longitude,
      position.accuracy,
      position.altitude,
      position.speed,
    );
  }
}
