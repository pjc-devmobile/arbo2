import 'package:arbo/app/modules/core/models/midia.dart';
import 'package:arbo/app/modules/core/repositories/midiasaprender_repository.dart';
import 'package:arbo/app/modules/start/controllers/start_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'learn_store.g.dart';

class LearnStore = _LearnStoreBase with _$LearnStore;

abstract class _LearnStoreBase with Store implements Disposable{
  final StartStore startStore = Modular.get<StartStore>();
  final MidiasAprenderRepository _repository = MidiasAprenderRepository();

  @observable
  List<Midia>? mediasWatch, mediasRead;

  _LearnStoreBase() {
    _getMedias();
  }

  @action
  _getMedias() async{
    mediasWatch = await _repository.getMidiasByType(TipoMidia.LINK_YOUTUBE);
    mediasRead = await _repository.getMidiasByType(TipoMidia.LINK_SITE);
  }

  @override
  void dispose() {

  }

  void toggleShowingTabBar() => startStore.toggleShowingTabBar();

  @computed
  get showingTabBar => startStore.showingTabBar;

}