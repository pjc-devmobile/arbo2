import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class DistanceDocSnapshot {
  final QueryDocumentSnapshot documentSnapshot;
  double? distance;

  DistanceDocSnapshot(this.documentSnapshot, this.distance);
}
