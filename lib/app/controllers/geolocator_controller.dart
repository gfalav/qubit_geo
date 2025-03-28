import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GeolocatorController extends GetxController {
  final lat = 0.0.obs;
  final lng = 0.0.obs;
  final speed = 0.0.obs;
  final alt = 0.0.obs;
  final accur = 0.0.obs;

  @override
  void onInit() {
    getPosition();
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings).listen((
      Position? position,
    ) {
      if (position != null) {
        if (Geolocator.distanceBetween(
              lat.value,
              lng.value,
              position.latitude,
              position.longitude,
            ) >
            10) {
          lat.value = position.latitude;
          lng.value = position.longitude;
          speed.value = position.speed;
          alt.value = position.altitude;
          accur.value = position.accuracy;
        }
      }
    });
    super.onInit();
  }

  Future<void> getPosition() async {
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
    lat.value = position.latitude;
    lng.value = position.longitude;
    speed.value = position.speed;
    alt.value = position.altitude;
    accur.value = position.accuracy;
  }
}
