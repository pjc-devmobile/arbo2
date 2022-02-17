import 'package:arbo/app/modules/core/models/arvore.dart';
import 'package:arbo/app/modules/core/models/status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:utils/utils.dart';
import 'package:arbo/app/shared/responsive_values.dart';

class ArvoresRepository {
  final _db = FirebaseFirestore.instance;
  final _collectionTreePath = "arvores";

  ///Create

  Future createTree(Arvore arvore) async {
    return _db.collection(_collectionTreePath).doc(arvore.id).set(arvore.toJson());
  }

  Stream<List<Arvore>> getTreesInLocation(Coordinates myLocation, {double radius = 50, String status = Status.ATIVO}) {
    final geo = Geoflutterfire();
    GeoFirePoint center = geo.point(latitude: myLocation.latitude, longitude: myLocation.longitude);

    var collectionReference = FirebaseFirestore.instance.collection(_collectionTreePath);

    String field = 'endereco.point';

    return geo.collection(collectionRef: collectionReference).within(
          center: center,
          radius: radius,
          field: field,
          status: status,
        ).map((event) => event.map((e) => Arvore.fromJson(e.data() as Map<String, dynamic>)).toList());
  }

  Future<List<Arvore>> getTreesByStatus({String status = Status.ATIVO}) {
    return _db
        .collection(_collectionTreePath)
        .where("status", isEqualTo: status)
        .get()
        .then((value) => value.docs.map((e) => Arvore.fromJson(e.data())).toList());
  }

  String getNextIdTree() {
    return _db.collection(_collectionTreePath).doc().id;
  }

  ///Update
  Future changeTreeStatus(Arvore arvore, String status) async {
    return _db.collection(_collectionTreePath).doc(arvore.id).update({
      "status": status,
      "dataAlteracao": FieldValue.serverTimestamp(),
    });
  }
}
