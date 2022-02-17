import 'package:arbo/app/modules/core/models/midia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MidiasAprenderRepository {
  final _db = FirebaseFirestore.instance;
  final _collectionPath = "midiasAprender";

  ///Create
  Future createMedia(Midia media) {
    return _db.collection(_collectionPath)
        .doc(media.id)
        .set(media.toJson());
  }

  Future updateMedia(Midia media) {
    return _db.collection(_collectionPath)
        .doc(media.id)
        .update(media.toJson());
  }

  ///Get
  Future<List<Midia>> getMidiasByType(String type) {
    return _db
        .collection(_collectionPath)
        .where("tipo", isEqualTo: type)
        .get()
        .then((value) => value.docs.map((e) => Midia.fromJson(e.data())).toList());
  }

  ///Delete
  Future deleteMedia(String id) {
    return _db.collection(_collectionPath)
        .doc(id)
        .delete();
  }

  String getNextIdMidia() {
    return _db.collection(_collectionPath).doc().id;
  }
}
