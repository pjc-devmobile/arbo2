import 'package:arbo/app/modules/core/models/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class UsuarioRepository {
  final _db = FirebaseFirestore.instance;
  final _collectionPath = "usuarios";

  ///Create

  Future createUsuario(Usuario usuario) async {
    return _db.collection(_collectionPath).doc(usuario.id).set(usuario.toJson());
  }

  Future updateUsuario(Usuario usuario) async {
    Map<String, dynamic> json = usuario.toJson();
    json.remove("status");
    json.remove("dataCadastro");

    return _db.collection(_collectionPath).doc(usuario.id).update(json);
  }

  Future updateEmailAndPassword(String email, String password) async {
    final updateSenha = FirebaseFunctions.instance.httpsCallable(
      'utils-updateEmailSenha',
    );

    var json = Map<String, String>();
    json["email"] = email;
    json["senha"] = password;

    ///Chama a função do firebase
    var res = await updateSenha.call(json).then((value) => value.data).catchError((error) {
      throw error.toString();
    });

    if (res["statusCode"] != 200) throw "Erro";
  }

  ///Get
  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUsuarioListener(id) {
    return _db.collection(_collectionPath).doc(id).snapshots();
  }

  Future<List<Usuario>> getUsuariosPorTipo(String tipo) {
    return _db
        .collection(_collectionPath)
        .where("tipoUsuario", isEqualTo: tipo)
        .get()
        .then((value) => value.docs.map((e) => Usuario.fromJson(e.data())).toList());
  }

  Future<List<Usuario>> getUsuarios() {
    return _db
        .collection(_collectionPath)
        .get()
        .then((value) => value.docs.map((e) => Usuario.fromJson(e.data())).toList());
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserById(id) {
    return _db.collection(_collectionPath).doc(id).get();
  }

  Future<bool> getCpfUsuarioExists(cpf) async {
    final fecharEstabelecimento = FirebaseFunctions.instance.httpsCallable(
      'utils-cpfMotoboyExists',
    );

    var json = Map<String, String>();
    json["cpf"] = cpf;

    ///Chama a função do firebase
    var res = await fecharEstabelecimento.call(json).then((value) => value.data).catchError((error) {
      throw error.toString();
    });

    if (res["statusCode"] != 200)
      throw "Erro";
    else
      return res["exists"];
  }

  Future<bool> getPhoneExists(phone) async {
    final fecharEstabelecimento = FirebaseFunctions.instance.httpsCallable(
      'utils-celularExists',
    );

    var json = Map<String, String>();
    json["celular"] = phone;

    ///Chama a função do firebase
    var res = await fecharEstabelecimento.call(json).then((value) => value.data).catchError((error) {
      throw error.toString();
    });

    if (res["statusCode"] != 200)
      throw "Erro";
    else
      return res["exists"];
  }

  Future<bool> getEmailExists(email) async {
    final fecharEstabelecimento = FirebaseFunctions.instance.httpsCallable(
      'utils-emailExists',
    );

    var json = Map<String, String>();
    json["email"] = email;

    ///Chama a função do firebase
    var res = await fecharEstabelecimento.call(json).then((value) => value.data).catchError((error) {
      throw error.toString();
    });

    if (res["statusCode"] != 200)
      throw "Erro";
    else
      return res["exists"];
  }
}
