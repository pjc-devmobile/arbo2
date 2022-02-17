import 'dart:io';
import 'dart:typed_data';

import 'package:arbo/app/modules/core/models/midia.dart';
import 'package:arbo/app/modules/core/repositories/images_repository.dart';
import 'package:arbo/app/modules/core/repositories/midiasaprender_repository.dart';
import 'package:arbo/app/shared/components/progress_dialog.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/form.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'new_media_web_store.g.dart';

class NewMediaWebStore = _NewMediaWebStoreBase with _$NewMediaWebStore;

abstract class _NewMediaWebStoreBase with Store implements Disposable {
  Midia? _media;
  late String mediaType;
  final MidiasAprenderRepository _repository = MidiasAprenderRepository();
  final ImagesRepository _imagesRepository = ImagesRepository();

  @observable
  File? image;
  @observable
  Uint8List? bytesImage;

  @observable
  String title = "", description = "", url = "";

  @action
  setImage(File image) => this.image = image;

  @action
  setBytesImage(bytesImage) => this.bytesImage = bytesImage;

  @action
  setProperty({String? title, String? description, String? url, String? urlMin}) {
    if (title != null) this.title = title;

    if (description != null) this.description = description;

    if (url != null)
      this.url = url;
  }

  @computed
  bool get fieldsFill {
    if (title.isEmpty) return false;

    if (url.isEmpty) return false;

    if(media == null && (image == null && bytesImage == null))
      return false;

    return true;
  }

  set media(Midia? media) {
    _media = media;
    setProperty(title: media!.titulo, urlMin: media.urlMin, description: media.descricao, url: media.url);
  }

  Midia? get media => _media;

  @override
  void dispose() {}

  void save(GlobalKey<FormState> formKey, BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      builder: (context) => ProgressDialog(title:S.to.aguarde),
    );

    String idMidia = this.media == null ? _repository.getNextIdMidia() : this.media!.id;
    String urlMin;

    if (image == null && bytesImage == null) {
      urlMin = this.media!.urlMin!;
    } else
      urlMin = (await _imagesRepository.uploadImagem("midiasAprender/$idMidia/$idMidia", fileImagem: image, bytesImage: bytesImage)).url;

    Midia media;
    if(this.media == null)
      media = Midia(
        id: idMidia,
        tipo: mediaType,
        titulo: title,
        url: url,
        urlMin: urlMin,
        descricao: description.isEmpty ? null : description,
      );
    else{
      media = this.media!;
      media.titulo = title;
      media.url = url;
      media.urlMin = urlMin;
      media.descricao= description.isEmpty ? null : description;
    }

    await (this.media == null
        ? _repository.createMedia(media)
        : _repository.updateMedia(media));

    Modular.to.pop();
    Modular.to.pop(media);
  }

  void chooseImage() async {
    var imagePicker = await ImagePicker()
        .getImage(maxHeight: 916, maxWidth: 916, source: ImageSource.gallery, imageQuality: 70);

    if (imagePicker != null) {
      if (kIsWeb) {
        final bytes = await imagePicker.readAsBytes();
        bytesImage = bytes; ///Uint8List
      }else
        image = File(imagePicker.path);
    }
  }
}
