import 'package:arbo/app/modules/core/models/estado_ativo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EstadosAtivosRepository {
  final _db = FirebaseFirestore.instance;
  final _collectionPath = "estadosAtivos";

  ///Create

  ///Get
  Future<List<EstadoAtivo>> getStatesActive() {
    return _db
        .collection(_collectionPath)
        .orderBy("cidadesAtivas", descending: true)
        .get()
        .then((value) => value.docs.map((e) => EstadoAtivo.fromJson(e.data())).toList());
  }

  ///Delete
}
