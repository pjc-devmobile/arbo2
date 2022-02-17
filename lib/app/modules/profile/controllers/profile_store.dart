import 'package:arbo/app/modules/core/controllers/app_store.dart';
import 'package:arbo/app/modules/core/models/usuario.dart';
import 'package:arbo/app/modules/start/controllers/start_store.dart';
import 'package:arbo/app/router_list.dart';
import 'package:arbo/app/shared/components/progress_dialog.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStoreBase with _$ProfileStore;

abstract class _ProfileStoreBase with Store implements Disposable {
  final StartStore startStore = Modular.get<StartStore>();
  final AppStore appStore = Modular.get<AppStore>();

  @override
  void dispose() {}

  void toggleShowingTabBar() => startStore.toggleShowingTabBar();

  @computed
  get showingTabBar => startStore.showingTabBar;

  @computed
  Usuario get currentUsuario => appStore.currentUsuario!;

  void logOff(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ProgressDialog(
        title:S.to.aguarde,
      ),
      useRootNavigator: true,
    );

    await appStore.signOut();
    Modular.to.pop();
    Modular.to.navigate(RouterList.SPLASH);
  }
}
