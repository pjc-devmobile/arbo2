import 'package:arbo/app/modules/core/models/midia.dart';
import 'package:arbo/app/modules/core/repositories/midiasaprender_repository.dart';
import 'package:arbo/app/modules/web/modules/learn/views/newmedia/new_media_web_dialog.dart';
import 'package:arbo/app/modules/web/modules/learn/views/newmedia/new_media_web_store.dart';
import 'package:arbo/app/shared/components/confirm_dialog.dart';
import 'package:arbo/app/shared/components/progress_dialog.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'learn_watch_web_store.g.dart';

class LearnWatchWebStore = _LearnWatchWebStoreBase with _$LearnWatchWebStore;

abstract class _LearnWatchWebStoreBase with Store implements Disposable{

  final MidiasAprenderRepository _repository = MidiasAprenderRepository();

  @observable
  ObservableList<Midia>? mediasWatch;

  _LearnWatchWebStoreBase() {
    _getMedias();
  }

  @action
  _getMedias() async{
    final list = await _repository.getMidiasByType(TipoMidia.LINK_YOUTUBE);
    mediasWatch = ObservableList.of(list);
  }

  @override
  void dispose() {

  }

  Future editMedia(Midia? media, BuildContext context) async{
    Modular.get<NewMediaWebStore>().mediaType = TipoMidia.LINK_YOUTUBE;
    Modular.get<NewMediaWebStore>().media = media;

    media = await showDialog(
      context: context,
      builder: (context) => NewMediaWebDialog(),
    );

    if (media != null) {
      if (mediasWatch == null)
        mediasWatch = ObservableList.of([media]);
      else {
        mediasWatch!.remove(media);
        mediasWatch!.add(media);
      }
    }
  }

  @action
  Future deleteMedia(Midia media, BuildContext context)async {

    bool confirmDelete = await showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title:S.to.excluir + "?",
        buttonConfirmar:S.to.excluir,
        buttonCancelar:S.to.cancelar,
        info:S.to.desejaRealmenteExluir.replaceAll("?1",S.to.estaMidia),
      ),
    );

    if(confirmDelete){
      showDialog(
        context: context,
        builder: (context) => ProgressDialog(title:S.to.aguarde),
      );

      await _repository.deleteMedia(media.id);
      mediasWatch!.remove(media);
      Modular.to.pop();
    }
  }

  @action
  Future newMedia(BuildContext context) async{
    Modular.get<NewMediaWebStore>().mediaType = TipoMidia.LINK_YOUTUBE;

    Midia? media = await showDialog(
      context: context,
      builder: (context) => NewMediaWebDialog(),
    );

    if (media != null) {
      if (mediasWatch == null)
        mediasWatch = ObservableList.of([media]);
      else
        mediasWatch!.add(media);
    }
  }

}