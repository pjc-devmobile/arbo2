import 'package:arbo/app/modules/core/models/token.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppRepository {

  final _db = FirebaseFirestore.instance;
  final _collectionTokensPath = "tokens";
  final _collectionAppPath = "app";

  ///Create

  Future saveToken(String idUsuario, String token) async {
    Tokens tokens;

    var data = await _db.collection(_collectionTokensPath).doc(idUsuario).get();
    if (data.data() == null)
      tokens = Tokens(id: idUsuario, tokens: [token]);
    else {
      tokens = Tokens.fromJson(data.data()!);
      tokens.dataAlteracao = null;
      tokens.tokens!.add(token);
      tokens.tokens = tokens.tokens!.toSet().toList();
    }

    return _db
        .collection(_collectionTokensPath)
        .doc(idUsuario)
        .set(tokens.toJson());
  }

  Future removeToken(String idUsuario, String token) async {
    Tokens tokens;

    var data = await _db.collection(_collectionTokensPath).doc(idUsuario).get();
    if (data.data() == null) return;

    tokens = Tokens.fromJson(data.data()!);

    tokens.dataAlteracao = null;
    tokens.tokens!.remove(token);

    return _db
        .collection(_collectionTokensPath)
        .doc(idUsuario)
        .set(tokens.toJson());
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getAppInfo() async {
    return _db.collection(_collectionAppPath).doc("app").get();
  }
}
