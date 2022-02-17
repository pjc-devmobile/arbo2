import 'package:arbo/app/modules/core/models/arvore.dart';
import 'package:arbo/app/modules/core/models/status.dart';
import 'package:arbo/app/modules/core/repositories/arvores_repository.dart';
import 'package:arbo/app/shared/components/progress_dialog.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'trees_pending_web_store.g.dart';

class TreesPendingWebStore = _TreesPendingWebStoreBase with _$TreesPendingWebStore;

abstract class _TreesPendingWebStoreBase with Store implements Disposable {
  final ArvoresRepository _repository = ArvoresRepository();

  @observable
  ObservableList<Arvore>? trees;

  _TreesPendingWebStoreBase() {
    _getTrees();
  }

  @action
  _getTrees() async {
    final list = await _repository.getTreesByStatus(status: Status.PENDENTE_ANALISE);
    trees = ObservableList.of(list);
  }

  @override
  void dispose() {}

  void detailsTree(Arvore tree) {
    //Modular.to.navigate(RouterList.CITIES_ACTIVE_WEB_MODULE, arguments: state);
  }

  @action
  Future decline(Arvore tree, BuildContext context) async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ProgressDialog(
        title:S.to.aguarde,
      ),
    );

    await _repository.changeTreeStatus(tree, Status.RECUSADO);
    trees!.remove(tree);
    Modular.to.pop();
  }

  @action
  Future approve(Arvore tree, BuildContext context) async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ProgressDialog(
        title:S.to.aguarde,
      ),
    );

    await _repository.changeTreeStatus(tree, Status.ATIVO);
    trees!.remove(tree);
    Modular.to.pop();
  }
}
