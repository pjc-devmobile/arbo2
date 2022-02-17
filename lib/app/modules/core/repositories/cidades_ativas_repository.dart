import 'package:arbo/app/modules/core/models/cidade_ativa.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CidadestivasRepository {
  final _db = FirebaseFirestore.instance;
  final _collectionPath = "cidadesAtivas";

  ///Create

  ///Get
  Future<List<CidadeAtiva>> getCitiesActiveByState(String state) {
    return _db
        .collection(_collectionPath)
        .where("estado", isEqualTo: state)
        .orderBy("voluntariosColaborando", descending: true)
        .get()
        .then((value) => value.docs.map((e) => CidadeAtiva.fromJson(e.data())).toList());
  }

  ///Delete
}
