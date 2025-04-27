import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/shared/controllers/user_controller.dart';

class GeolocatorController extends GetxController {
  final db = FirebaseFirestore.instance;
  final UserController userController = Get.put(UserController());

  final lat = 0.0.obs;
  final lng = 0.0.obs;
  final speed = 0.0.obs;
  final alt = 0.0.obs;
  final accur = 0.0.obs;
  final speedAcc = 0.0.obs; //Precisión de la velocidad

  final recordPositionEnabled = false.obs; //Graba o no en BD la posición

  @override
  void onInit() async {
    late LocationSettings locationSettings;

    bool serviceEnabled;
    LocationPermission permission;

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

    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 30),
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationText:
              "Example app will continue to receive your location even when you aren't using it",
          notificationTitle: "Running in Background",
          enableWakeLock: true,
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 10,
        pauseLocationUpdatesAutomatically: true,
        showBackgroundLocationIndicator: false,
      );
    } else if (kIsWeb) {
      locationSettings = WebSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
        maximumAge: Duration(seconds: 5),
      );
    } else {
      locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      );
    }

    Geolocator.getPositionStream(locationSettings: locationSettings).listen((
      Position? position,
    ) {
      updatePosition(position);
    });
    await getPosition();
    super.onInit();
  }

  Future<void> updatePosition(Position? position) async {
    if (position != null) {
      final distance = Geolocator.distanceBetween(
        lat.value,
        lng.value,
        position.latitude,
        position.longitude,
      );
      if (distance > 10) {
        //actualiza position
        lat.value = position.latitude;
        lng.value = position.longitude;
        speed.value = position.speed;
        alt.value = position.altitude;
        accur.value = position.accuracy;
        speedAcc.value = position.speedAccuracy;
        //guarda en firestore si está activa la flag
        if (recordPositionEnabled.value) {
          final pos = <String, dynamic>{
            'date': position.timestamp,
            'lat': position.latitude,
            'lng': position.longitude,
            'speed': position.speed,
            'accuracy': position.accuracy,
            'name': userController.displayName.value,
            'speedAcc': position.speedAccuracy,
          };
          await db
              .collection('lastPosition')
              .doc(userController.uid.toString())
              .set(pos);
          await db.collection('positions').add(pos);
        }
      }
    }
  }

  Future<void> getPosition() async {
    final position = await Geolocator.getCurrentPosition();
    lat.value = position.latitude;
    lng.value = position.longitude;
    speed.value = position.speed;
    alt.value = position.altitude;
    accur.value = position.accuracy;
    speedAcc.value = position.speedAccuracy;
  }
}
