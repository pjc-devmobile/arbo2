import 'dart:io';
import 'dart:typed_data';

import 'package:arbo/app/modules/core/models/imagem.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:utils/utils/util/utils.dart';

class ImagesRepository {
  Future<Imagem> uploadImagem(String absolutePath, {File? fileImagem, Uint8List? bytesImage}) async {
    final Reference storageReference = FirebaseStorage.instance.ref().child(absolutePath);
    final UploadTask uploadTask = fileImagem == null ? storageReference.putData(bytesImage!) : storageReference.putFile(fileImagem);
    await uploadTask;

    String urlDownload = await storageReference.getDownloadURL();
    Imagem imagem = Imagem(id: null, url: urlDownload, urlMin: "");

    ///Upload image min
    if(fileImagem != null) {
      fileImagem = await Utils.redimensionarImagem(fileImagem);
      final Reference storageReferenceMin = FirebaseStorage.instance.ref().child(absolutePath + "_min");
      final UploadTask uploadTaskMin = storageReferenceMin.putFile(fileImagem);
      await uploadTaskMin;

      String urlDownloadMin = await storageReference.getDownloadURL();
      imagem.urlMin = urlDownloadMin;
    }else
      imagem.urlMin = imagem.url;

    return imagem;
  }
}
