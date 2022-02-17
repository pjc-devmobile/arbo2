
import 'package:arbo/app/modules/core/controllers/app_store.dart';
import 'package:arbo/app/modules/core/models/status.dart';
import 'package:arbo/app/modules/core/models/usuario.dart';
import 'package:arbo/app/shared/components/custom_snack_barr.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../router_list.dart';

part 'splash_web_store.g.dart';

class SplashWebStore = _SplashWebStoreBase with _$SplashWebStore;

abstract class _SplashWebStoreBase with Store {
  final appStore = Modular.get<AppStore>();

  _SplashWebStoreBase() {
    appStore.appInfo.then((value) => verifyUser()).catchError((err){
      showCustomSnackBarrError(texto: err.toString());
    });
  }

  verifyUser() {
    appStore.getCurrentUsuario().then((usr) {
      ///Usuário não logado
      if (appStore.firebaseUser == null) {
        Modular.to.pushReplacementNamed(RouterList.SIGNIN_WEB_MODULE);
      }

      ///Usuário não ADM
      else if (usr!.tipoUsuario == TipoUsuario.ADM || usr.tipoUsuario == TipoUsuario.VOLUNTARIO)
        verifyAccountUser(usr);
      else {
        appStore.signOut();
        Modular.to.pushReplacementNamed(RouterList.SIGNIN_WEB_MODULE);
      }
    });
  }

  verifyAccountUser(Usuario user) async {
    if (user.status == Status.ATIVO)
      Modular.to.navigate(RouterList.HOME_MODULE_WEB, arguments: false);
    ///HOME
    else
      showAlertUserBlocked(user);
  }

  showAlertUserBlocked(Usuario user) {}

  showAlertUpdate() {
    Modular.to.pushReplacementNamed(RouterList.UPDATE_APP);
  }
}
