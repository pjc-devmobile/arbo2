import 'package:arbo/app/modules/core/controllers/app_store.dart';
import 'package:arbo/app/modules/core/models/erro.dart';
import 'package:arbo/app/modules/core/models/usuario.dart';
import 'package:arbo/app/router_list.dart';
import 'package:arbo/app/shared/components/custom_snack_barr.dart';
import 'package:arbo/app/shared/components/progress_dialog.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:utils/utils.dart';
import 'package:utils/utils/constants/codes.dart';

part 'sign_in_user_password_web_store.g.dart';

class SignInUserPasswordWebStore = _SignInUserPasswordWebStoreBase with _$SignInUserPasswordWebStore;

abstract class _SignInUserPasswordWebStoreBase with Store {
  final Validator v = Validator();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final appStore = Modular.get<AppStore>();

  String email = "", password = "";

  void back() {
    Modular.to.pop();
  }

  void signin(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ProgressDialog(
        title:S.to.aguarde,
      ),
    );

    await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) async {
      final usuario = await appStore.getCurrentUsuario();
      if(usuario!.tipoUsuario != TipoUsuario.ADM && usuario.tipoUsuario != TipoUsuario.VOLUNTARIO)
        throw Erro(code: Codes.USUARIO_SEM_PERMISSAO, message: "É preciso acessar com uma conta de administrador");
      Modular.to.navigate(RouterList.SPLASH);
    }).catchError((error) {
      Modular.to.pop();
      _showErro(error, context);
    });
  }

  void _showErro(error, context) {
    try {
      if (error.code == Codes.EMAIL_INCORRETO)
        showCustomSnackBarrError(texto: S.to.emailInvalido);
      else if (error.code == Codes.SENHA_INCORRETA)
        showCustomSnackBarrError(texto:S.to.senhaIncorreta,
        );
      else if(error.code == Codes.USUARIO_SEM_PERMISSAO)
        showCustomSnackBarrError(texto: error.message,
        );
    } catch (ex) {
      showCustomSnackBarrError(texto:S.to.ocorreuErro,
      );
    }
  }
}
