import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/shared/controllers/user_controller.dart';

class GeolocatorController extends GetxController {
  final lat = 0.0.obs;
  final lng = 0.0.obs;
  final speed = 0.0.obs;
  final alt = 0.0.obs;
  final accur = 0.0.obs;

  final recordPositionEnabled = false.obs; //Graba o no en BD la posición

  //map origin to current location
  final setOriginFlag = false.obs;

  //map rotation
  final rotationFlag = false.obs;

  //zoom level
  final zoomIn = false.obs;
  final zoomOut = false.obs;

  final db = FirebaseFirestore.instance;
  final UserController userController = Get.put(UserController());

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
          //actualiza position
          lat.value = position.latitude;
          lng.value = position.longitude;
          speed.value = position.speed;
          alt.value = position.altitude;
          accur.value = position.accuracy;
          //guarda en firestore si está activa la flag
          if (recordPositionEnabled.value) {
            final pos = <String, dynamic>{
              'date': position.timestamp,
              'lat': position.latitude,
              'lng': position.longitude,
              'speed': position.speed,
              'accuracy': position.accuracy,
              'name': userController.displayName.value,
            };
            db
                .collection('lastPosition')
                .doc(userController.uid.toString())
                .set(pos);
            db.collection('positions').add(pos);
          }
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
