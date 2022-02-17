import 'package:arbo/app/modules/core/controllers/app_store.dart';
import 'package:arbo/app/router_list.dart';
import 'package:arbo/app/shared/components/custom_snack_barr.dart';
import 'package:arbo/app/shared/components/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:utils/utils.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:utils/utils/constants/codes.dart';

part 'sign_in_user_password_store.g.dart';

class SignInUserPasswordStore = _SignInUserPasswordStoreBase with _$SignInUserPasswordStore;

abstract class _SignInUserPasswordStoreBase with Store{

  final Validator v = Validator();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final appStore = Modular.get<AppStore>();

  String email = "", password="";

  void back(){
    Modular.to.pop();
  }

  void signin(BuildContext context) async{
    if (!formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ProgressDialog(
        title:S.to.aguarde,
      ),
    );

    await _auth.signInWithEmailAndPassword(email: email, password: password)
    .then((value) async {
      await appStore.updateToken(null);
      Modular.to.navigate(RouterList.SPLASH);
    }).catchError((error){
      Modular.to.pop();
      _showErro(error, context);
    });
  }

  void _showErro(error, context) {
    try {
      if (error.code == Codes.EMAIL_INCORRETO)
        showCustomSnackBarrError(texto:S.to.emailInvalido);
      else if (error.code == Codes.SENHA_INCORRETA)
        showCustomSnackBarrError(
          texto:S.to.senhaIncorreta,
        );
      else
        throw "";
    } catch (ex) {
      showCustomSnackBarrError(texto:S.to.ocorreuErro);
    }
  }
}