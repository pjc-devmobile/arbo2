import 'dart:io';

import 'package:arbo/app/modules/core/controllers/app_store.dart';
import 'package:arbo/app/modules/core/models/app.dart';
import 'package:arbo/app/modules/core/models/status.dart';
import 'package:arbo/app/modules/core/models/usuario.dart';
import 'package:arbo/app/shared/components/confirm_dialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:mobx/mobx.dart';
import 'package:package_info/package_info.dart';
import 'package:utils/utils/util/location_utils.dart';
import 'package:utils/utils/util/utils.dart';

import '../../../router_list.dart';

part 'splash_store.g.dart';

class SplashStore = _SplashStoreBase with _$SplashStore;

abstract class _SplashStoreBase with Store {
  final appStore = Modular.get<AppStore>();

  _SplashStoreBase() {
    verifyPermissionLocation();
  }

  ///#1
  verifyPermissionLocation() async {
    bool permission = await LocationUtils.temPermissaoLocalizacao;

    if (permission)
      verifyAppVersion();
    else
      SystemNavigator.pop();
  }

  ///#2
  verifyAppVersion() async {
    App app = await appStore.appInfo;
    PackageInfo packageInfo = await Utils.getPackageInfo();

    if (Platform.isAndroid) {
      if (int.parse(packageInfo.buildNumber) < app.android.versaoMinima!) {
        showAlertUpdate();
        return;
      }
    } else {
      if (int.parse(packageInfo.buildNumber) < app.ios.versaoMinima!) {
        showAlertUpdate();
        return;
      }
    }

    verifyUser();
  }

  ///#3
  verifyUser() {
    appStore.getCurrentUsuario().then((usr) {
      ///Usuário não logado
      if (appStore.firebaseUser == null) {
        Modular.to.pushReplacementNamed(RouterList.SIGNIN_MODULE);
      }

      ///Usuário logado que não tem o objeto usuário cadastrado do BD
      else if (usr == null) {
        Modular.to.pushReplacementNamed(RouterList.SIGNUP_USER_DATA);
      } else
        verifyAccountUser(usr);
    });
  }

  verifyAccountUser(Usuario user) async {
    ///HOME
    if (user.status == Status.ATIVO)
      Modular.to.navigate(RouterList.HOME_MODULE);
    else
      showAlertUserBlocked(user);
  }

  showAlertUserBlocked(Usuario user) {}

  showAlertUpdate() {
    Modular.to.pushReplacementNamed(RouterList.UPDATE_APP);
  }
}
