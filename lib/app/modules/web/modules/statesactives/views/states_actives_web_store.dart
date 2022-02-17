import 'package:arbo/app/modules/core/models/estado_ativo.dart';
import 'package:arbo/app/modules/core/repositories/estados_ativos_repository.dart';
import 'package:arbo/app/router_list.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'states_actives_web_store.g.dart';

class StatesActivesWebStore = _StatesActivesWebStoreBase with _$StatesActivesWebStore;

abstract class _StatesActivesWebStoreBase with Store implements Disposable {
  final EstadosAtivosRepository _repository = EstadosAtivosRepository();

  @observable
  ObservableList<EstadoAtivo>? states;

  _StatesActivesWebStoreBase() {
    _getStates();
  }

  @action
  _getStates() async {
    final list = await _repository.getStatesActive();
    states = ObservableList.of(list);
  }

  @override
  void dispose() {}

  void detailsState(EstadoAtivo state) {
    Modular.to.navigate(RouterList.CITIES_ACTIVE_MODULE_WEB, arguments: state);
  }
}
