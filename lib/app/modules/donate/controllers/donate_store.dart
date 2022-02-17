import 'package:arbo/app/modules/core/controllers/app_store.dart';
import 'package:arbo/app/modules/core/models/app.dart';
import 'package:arbo/app/modules/start/controllers/start_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'donate_store.g.dart';

class DonateStore = _DonateStoreBase with _$DonateStore;

abstract class _DonateStoreBase with Store implements Disposable{

  final StartStore _startStore = Modular.get<StartStore>();
  final AppStore _appStore = Modular.get<AppStore>();

  @override
  void dispose() {

  }

  void toggleShowingTabBar() => _startStore.toggleShowingTabBar();

  @computed
  get showingTabBar => _startStore.showingTabBar;

  App get app => _appStore.appInfoSync;
}