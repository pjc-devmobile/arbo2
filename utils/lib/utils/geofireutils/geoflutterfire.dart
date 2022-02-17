import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:utils/utils/geofireutils/collection.dart';
import 'package:utils/utils/geofireutils/point.dart';

class Geoflutterfire {
  Geoflutterfire();

  GeoFireCollectionRef collection({required CollectionReference collectionRef}) {
    return GeoFireCollectionRef(collectionRef);
  }

  GeoFirePoint point({required double latitude, required double longitude}) {
    return GeoFirePoint(latitude, longitude);
  }
}
