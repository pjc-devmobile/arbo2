import 'package:arbo/app/modules/core/controllers/app_store.dart';
import 'package:arbo/app/router_list.dart';
import 'package:arbo/app/shared/components/custom_snack_barr.dart';
import 'package:arbo/app/shared/components/progress_dialog.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:toast/toast.dart';
import 'package:utils/utils.dart';
import 'package:utils/utils/constants/colors.dart';

part 'sign_type_store.g.dart';

class SignTypeStore = _SignTypeStoreBase with _$SignTypeStore;

abstract class _SignTypeStoreBase with Store {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final appStore = Modular.get<AppStore>();

  void login() {
    Modular.to.pushNamed(RouterList.SIGNIN_USER_PASSWORD);
  }

  void signInGoogle(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ProgressDialog(
        title: S.to.aguarde,
      ),
    );

    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = (await _googleSignIn.signIn().catchError((error) {
      _showErro(error, context);
      Modular.to.pop();
    }))!;
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await _auth.signInWithCredential(credential).then((result) {
      appStore.updateToken(null);
      Modular.to.navigate(RouterList.SPLASH);
    }).catchError((error) {
      Modular.to.pop();
      _showErro(error, context);
    });
  }

  void signInFacebook(BuildContext context) {
    Toast.show("Ainda não disponível", context,
        backgroundColor: ColorsConfig.redDarktColor.withOpacity(0.6), duration: 3);
  }

  void signUp() {
    Modular.to.pushNamed(RouterList.SIGNUP_USER_DATA);
  }

  void _showErro(error, context) {
    showCustomSnackBarrError(
      texto: S.to.ocorreuErro + ":\n" + error.message,
    );
  }
}
