import 'package:arbo/app/modules/core/models/midia.dart';
import 'package:arbo/app/modules/core/repositories/images_repository.dart';
import 'package:arbo/app/modules/core/repositories/midiasaprender_repository.dart';
import 'package:arbo/app/modules/web/modules/learn/views/newmedia/new_media_web_dialog.dart';
import 'package:arbo/app/modules/web/modules/learn/views/newmedia/new_media_web_store.dart';
import 'package:arbo/app/shared/components/confirm_dialog.dart';
import 'package:arbo/app/shared/components/progress_dialog.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'learn_read_web_store.g.dart';

class LearnReadWebStore = _LearnReadWebStoreBase with _$LearnReadWebStore;

abstract class _LearnReadWebStoreBase with Store implements Disposable {
  final MidiasAprenderRepository _repository = MidiasAprenderRepository();
  final ImagesRepository _imagesRepository = ImagesRepository();

  @observable
  ObservableList<Midia>? mediasRead;

  _LearnReadWebStoreBase() {
    _getMedias();
  }

  @action
  _getMedias() async {
    final list = await _repository.getMidiasByType(TipoMidia.LINK_SITE);
    mediasRead = ObservableList.of(list);
  }

  @override
  void dispose() {}

  Future editMedia(Midia? media, BuildContext context) async {
    Modular.get<NewMediaWebStore>().mediaType = TipoMidia.LINK_SITE;
    Modular.get<NewMediaWebStore>().media = media;

    media = await showDialog(
      context: context,
      builder: (context) => NewMediaWebDialog(),
    );

    if (media != null) {
      if (mediasRead == null)
        mediasRead = ObservableList.of([media]);
      else {
        mediasRead!.remove(media);
        mediasRead!.add(media);
      }
    }
  }

  @action
  Future deleteMedia(Midia media, BuildContext context) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title:S.to.excluir + "?",
        buttonConfirmar:S.to.excluir,
        buttonCancelar:S.to.cancelar,
        info:S.to.desejaRealmenteExluir.replaceAll("?1",S.to.estaMidia),
      ),
    );

    if (confirmDelete) {
      showDialog(
        context: context,
        builder: (context) => ProgressDialog(title:S.to.aguarde),
      );

      await _repository.deleteMedia(media.id);
      mediasRead!.remove(media);
      Modular.to.pop();
    }
  }

  @action
  Future newMedia(BuildContext context) async {
    Modular.get<NewMediaWebStore>().mediaType = TipoMidia.LINK_SITE;

    Midia? media = await showDialog(
      context: context,
      builder: (context) => NewMediaWebDialog(),
    );

    if (media != null) {
      if (mediasRead == null)
        mediasRead = ObservableList.of([media]);
      else
        mediasRead!.add(media);
    }
  }
}
