import 'package:arbo/app/modules/core/models/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class PagamentoRepository {
  final _db = FirebaseFirestore.instance;
  //final _collectionPath = "usuarios";

  Future createPayment(dynamic data) async {

    final criarCobranca = FirebaseFunctions.instance.httpsCallable(
      'pagamentos-criarcobranca',
    );

    ///Chama a função do firebase
    var res = await criarCobranca.call(data).then((value) => value.data).catchError((error) {
      throw error.toString();
    });

    if (res["statusCode"] != 200)
      throw "Erro";
    else
      return res;
  }
}
