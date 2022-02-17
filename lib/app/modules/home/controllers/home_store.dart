import 'package:arbo/app/modules/start/controllers/start_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store implements Disposable{

  StartStore? startStore;
  final bool showButtonMenu;

  _HomeStoreBase({this.showButtonMenu = true}) {
    if (!kIsWeb) startStore = Modular.get<StartStore>();
  }

  @override
  void dispose() {

  }

  void toggleShowingTabBar() => startStore!.toggleShowingTabBar();

  @computed
  get showingTabBar => startStore == null ? false : startStore!.showingTabBar;

}