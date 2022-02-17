import 'package:arbo/app/modules/core/controllers/app_store.dart';
import 'package:arbo/app/modules/core/models/usuario.dart';
import 'package:arbo/app/router_list.dart';
import 'package:arbo/app/shared/components/progress_dialog.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'start_web_store.g.dart';

class StartWebStore = _StartWebStoreBase with _$StartWebStore;

abstract class _StartWebStoreBase with Store implements Disposable {

  final _appStore = Modular.get<AppStore>();

  Usuario get currentUsuario=> _appStore.currentUsuario!;

  @override
  void dispose() {}

  @observable
  int currentIndex = 0;
  @action
  setCurrentIndex(int index) => currentIndex = index;

  @action
  void switchTab(int index) {

    currentIndex = index;
    switch (index) {
      case StartWebIndexs.HOME_INDEX:
        Modular.to.navigate(RouterList.HOME_MODULE_WEB, arguments: false);
        break;

      case StartWebIndexs.TREE_PENDING_INDEX:
        Modular.to.navigate(RouterList.TREE_PENDING_MODULE_WEB);
        break;

      case StartWebIndexs.STATES_ACTIVE_INDEX:
        Modular.to.navigate(RouterList.STATES_ACTIVE_MODULE_WEB);
        break;

      case StartWebIndexs.LEARN_READ_INDEX:
        Modular.to.navigate(RouterList.LEARN_READ_WEB);
        break;

      case StartWebIndexs.LEARN_WATCH_INDEX:
        Modular.to.navigate(RouterList.LEARN_WATCH_WEB);
        break;

      case StartWebIndexs.USERS_INDEX:
        Modular.to.navigate(RouterList.USERS_MODULE_WEB);
        break;
    }
  }

  void logOff(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ProgressDialog(
        title:S.to.aguarde,
      ),
      useRootNavigator: true,
    );

    await _appStore.signOut();
    Modular.to.pop();
    Modular.to.navigate(RouterList.SPLASH);
  }

}

abstract class StartWebIndexs {
  static const int HOME_INDEX = 0,
      TREE_PENDING_INDEX = 1,
      STATES_ACTIVE_INDEX = 2,
      LEARN_READ_INDEX = 3,
      LEARN_WATCH_INDEX = 4,
      USERS_INDEX = 5;
}
