import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MyMapController extends GetxController {
  //map origin to current location
  final setOriginFlag = false.obs;

  //map rotation
  final rotationFlag = false.obs;

  //zoom level
  final zoomIn = false.obs;
  final zoomOut = false.obs;

  final List<LatLng> points = <LatLng>[].obs;

  void getPoints() async {
    final db = FirebaseFirestore.instance;
    final pointsRef = db.collection("positions");
    points.removeWhere((_) => true);
    pointsRef
        .where(
          "date",
          isGreaterThan: DateTime.now().subtract(Duration(days: 1)),
        )
        .orderBy("date", descending: false)
        .get()
        .then((res) {
          for (var i in res.docs) {
            points.add(LatLng(i.data()['lat'], i.data()['lng']));
          }
        });
  }
}
