import 'package:arbo/app/router_list.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'start_store.g.dart';

class StartStore = _StartStoreBase with _$StartStore;

abstract class _StartStoreBase with Store implements Disposable {
  @override
  void dispose() {}

  @observable
  int currentIndex = 0;
  @action
  setCurrentIndex(int index) => currentIndex = index;

  @observable
  bool showingTabBar = false;
  @action
  toggleShowingTabBar() => showingTabBar = !showingTabBar;

  @action
  void switchTab(int index) {

    currentIndex = index;
    switch (index) {
      case StartIndexs.HOME_INDEX:
        Modular.to.navigate(RouterList.HOME_MODULE);
        break;

      case StartIndexs.PROFILE_INDEX:
        Modular.to.navigate(RouterList.PROFILE_MODULE);
        break;

      case StartIndexs.MAPTREE_INDEX:
        Modular.to.navigate(RouterList.MAPTREE_MODULE);
        break;

      case StartIndexs.LEARN_INDEX:
        Modular.to.navigate(RouterList.LEARN_MODULE);
        break;

      case StartIndexs.DONATE_INDEX:
        Modular.to.navigate(RouterList.DONATE_MODULE);
        break;
    }
  }
}

abstract class StartIndexs {
  static const int HOME_INDEX = 0,
      PROFILE_INDEX = 1,
      MAPTREE_INDEX = 2,
      LEARN_INDEX = 3,
      DONATE_INDEX = 4;
}
