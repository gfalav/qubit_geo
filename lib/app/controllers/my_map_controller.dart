import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
  final List<Marker> markers = <Marker>[].obs;

  void getPoints() async {
    NumberFormat numberFormat = NumberFormat("#,##0", "en_US");
    QueryDocumentSnapshot<Map<String, dynamic>>? ant;
    var difM = 0.0;
    var difT = 0.0;
    var speed = 0.0;

    final db = FirebaseFirestore.instance;
    final pointsRef = db.collection("positions");
    points.removeWhere((_) => true);
    pointsRef
        .where(
          "date",
          isGreaterThan: DateTime.now().subtract(Duration(days: 7)),
        )
        .orderBy("date", descending: false)
        .get()
        .then((res) {
          for (var i in res.docs) {
            difM =
                ant != null
                    ? Geolocator.distanceBetween(
                      ant!.data()['lat'],
                      ant!.data()['lng'],
                      i.data()['lat'],
                      i.data()['lng'],
                    )
                    : 0.0;
            var timeA = ant != null ? ant!.data()['date'].toDate() : 0.0;
            var timeB = i.data()['date'].toDate();
            difT = ant != null ? timeB.difference(timeA).inMilliseconds : 0.0;
            speed = difM / difT * 3600;
            points.add(LatLng(i.data()['lat'], i.data()['lng']));
            markers.add(
              Marker(
                point: LatLng(i.data()['lat'], i.data()['lng']),
                child: Text(
                  numberFormat.format(speed),
                  style: TextStyle(
                    fontSize: 16,
                    color: () {
                      if (speed < 40) {
                        return Colors.green;
                      } else if (speed < 80) {
                        return Colors.yellow;
                      } else if (speed < 110) {
                        return Colors.orange;
                      } else {
                        return Colors.red;
                      }
                    }(),
                  ),
                ),
              ),
            );
            ant = i;
          }
        });
  }
}
