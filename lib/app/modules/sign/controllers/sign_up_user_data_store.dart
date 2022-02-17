import 'package:arbo/app/modules/core/controllers/app_store.dart';
import 'package:arbo/app/modules/core/models/endereco.dart';
import 'package:arbo/app/modules/core/models/pessoa.dart';
import 'package:arbo/app/modules/core/models/status.dart';
import 'package:arbo/app/modules/core/models/usuario.dart';
import 'package:arbo/app/modules/core/repositories/usuario_repository.dart';
import 'package:arbo/app/shared/components/custom_snack_barr.dart';
import 'package:arbo/app/shared/components/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:utils/utils.dart';
import 'package:utils/utils/constants/codes.dart';
import 'package:utils/utils/constants/constants.dart';
import 'package:utils/utils/util/estado_cidades_utils.dart';
import 'package:utils/utils/util/validators.dart';

import 'package:arbo/l10n/app_localization.dart';
import '../../../router_list.dart';

part 'sign_up_user_data_store.g.dart';

class SignUpUserDataStore = _SignUpUserDataStoreBase with _$SignUpUserDataStore;

abstract class _SignUpUserDataStoreBase with Store {
  _SignUpUserDataStoreBase() {
    appStore = Modular.get<AppStore>();
    if (appStore.firebaseUser != null) {
      fullName = appStore.firebaseUser!.displayName!;
      email = appStore.firebaseUser!.email!;
    }
  }

  final _usuarioRepository = UsuarioRepository();
  final controllerPhone = MaskedTextController(mask: "(00) 9 0000-0000");
  final controllerCity = TextEditingController();

  final Validator v = Validator();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late AppStore appStore;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String fullName = "", email = "", phone = "", password = "", repeatPassword = "", city = "", state = "";

  @observable
  bool acceptTerms = false;

  @action
  setAcceptTerms(at) => acceptTerms = at;

  void chooseCity(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ProgressDialog(
        title: S.to.aguarde,
      ),
    );
    List estados = await EstadoCidadesUtils.loadAssetEstados().whenComplete(() => Modular.to.pop());

    var estado = await showDialog(
      context: context,
      builder: (context) => EscolheEstadoDialog(
        estadosCidades: estados,
        titulo: S.to.estados,
      ),
    );
    if (estado == null) return;

    var cidade = await showDialog(
      context: context,
      builder: (context) => EscolherCidadeDialog(
        estadoCidades: estado,
        titulo: S.to.cidades,
        tituloPesquisa: S.to.filtrar,
      ),
    );

    if (cidade == null) return;

    controllerCity.text = cidade + " - " + estado.sigla;
    city = cidade;
    state = estado.nome;
  }

  void openTerms() {
    Utils.launchURL(Constants.URL_TERMOS_USO);
  }

  void signup(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    if (!acceptTerms) {
      showCustomSnackBarrError(texto: S.to.aceiteTermos);
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ProgressDialog(
        title: S.to.aguarde,
      ),
    );

    ///Firebase auth
    if (_auth.currentUser == null) {
      await _auth.createUserWithEmailAndPassword(email: email, password: password).catchError((error) {
        _showErro(error, context);
      });
    } else {
      ///Foi login com google ou facebook
      await _auth.currentUser!.updateEmail(email).catchError((error) => _showErro(error, context));
      await _auth.currentUser!.updatePassword(password).catchError((error) => _showErro(error, context));
      if (fullName != _auth.currentUser!.displayName)
        await _auth.currentUser!
            .updateProfile(displayName: fullName)
            .catchError((error) => _showErro(error, context));
    }

    appStore.updateToken(null);
    _createUserDoc(context);
  }

  void _createUserDoc(BuildContext context) async {
    var user = Usuario(
      id: _auth.currentUser!.uid,
      status: Status.ATIVO,
      tipoUsuario: TipoUsuario.USUARIO,
      pessoa: Pessoa(
        celular: phone,
        email: email,
        enderecoPrincipal: Endereco(cidade: city, estado: state),
        nome: fullName.substring(0, fullName.indexOf(" ")),
        sobrenome: fullName.substring(fullName.indexOf(" ") + 1),
      ),
    );

    await _usuarioRepository.createUsuario(user).then((value) {
      Modular.to.navigate(RouterList.SPLASH);
    }).catchError((error) {
      Modular.to.pop();
      _showErro(error, context);
    });
  }

  void _showErro(error, context) {
    Modular.to.pop();

    try {
      if (error.code == Codes.EMAIL_EM_USO)
        showCustomSnackBarrError(texto: S.to.emailEmUso);
      else
        throw "";
    } catch (ex) {
      print(error.code);
      showCustomSnackBarrError(texto: S.to.ocorreuErro);
    }
  }
}
