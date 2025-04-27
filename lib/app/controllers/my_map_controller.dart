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

  final List<Polyline> pLines = <Polyline>[].obs;
  final List<Marker> markers = <Marker>[].obs;

  void getPoints() async {
    print("Entre!!!");
    NumberFormat numberFormat = NumberFormat("#,##0", "en_US");
    QueryDocumentSnapshot<Map<String, dynamic>>? ant;
    var difM = 0.0;
    var difT = 0.0;
    var speed = 0.0;

    final db = FirebaseFirestore.instance;
    final pointsRef = db.collection("positions");
    pLines.removeWhere((_) => true);
    markers.removeWhere((_) => true);

    pointsRef
        .where(
          "date",
          isGreaterThan: DateTime.now().subtract(Duration(days: 1)),
        )
        .orderBy("date", descending: false)
        .get()
        .then((res) {
          for (var i in res.docs) {
            if (ant != null) {
              difM = Geolocator.distanceBetween(
                ant!.data()['lat'],
                ant!.data()['lng'],
                i.data()['lat'],
                i.data()['lng'],
              );
              difT =
                  i
                      .data()['date']
                      .toDate()
                      .difference(ant!.data()['date'].toDate())
                      .inMilliseconds
                      .toDouble();
              speed = difM / difT * 3600;
              pLines.add(
                Polyline(
                  points: [
                    LatLng(ant!.data()['lat'], ant!.data()['lng']),
                    LatLng(i.data()['lat'], i.data()['lng']),
                  ],
                  color:
                      speed < 40
                          ? Colors.green
                          : speed < 80
                          ? Colors.yellow
                          : speed < 110
                          ? Colors.orange
                          : Colors.red,
                  strokeWidth: 3.0,
                ),
              );
            }

            ant = i;
          }
        });
  }
}
