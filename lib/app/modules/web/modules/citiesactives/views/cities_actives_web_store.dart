import 'package:arbo/app/modules/core/models/cidade_ativa.dart';
import 'package:arbo/app/modules/core/models/estado_ativo.dart';
import 'package:arbo/app/modules/core/repositories/cidades_ativas_repository.dart';
import 'package:arbo/app/router_list.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'cities_actives_web_store.g.dart';

class CitiesActivesWebStore = _CitiesActivesWebStoreBase with _$CitiesActivesWebStore;

abstract class _CitiesActivesWebStoreBase with Store implements Disposable {
  final EstadoAtivo state;
  final CidadestivasRepository _repository = CidadestivasRepository();

  @observable
  ObservableList<CidadeAtiva>? cities;

  _CitiesActivesWebStoreBase({required this.state}) {
    _getCities();
  }

  @action
  _getCities() async {
    final list = await _repository.getCitiesActiveByState(state.estado);
    cities = ObservableList.of(list);
  }

  @override
  void dispose() {}

  void back(){
    Modular.to.navigate(RouterList.STATES_ACTIVE_MODULE_WEB);
  }

}
