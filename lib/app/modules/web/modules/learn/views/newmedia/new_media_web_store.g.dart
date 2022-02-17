// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_media_web_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewMediaWebStore on _NewMediaWebStoreBase, Store {
  Computed<bool>? _$fieldsFillComputed;

  @override
  bool get fieldsFill =>
      (_$fieldsFillComputed ??= Computed<bool>(() => super.fieldsFill,
              name: '_NewMediaWebStoreBase.fieldsFill'))
          .value;

  final _$imageAtom = Atom(name: '_NewMediaWebStoreBase.image');

  @override
  File? get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(File? value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$bytesImageAtom = Atom(name: '_NewMediaWebStoreBase.bytesImage');

  @override
  Uint8List? get bytesImage {
    _$bytesImageAtom.reportRead();
    return super.bytesImage;
  }

  @override
  set bytesImage(Uint8List? value) {
    _$bytesImageAtom.reportWrite(value, super.bytesImage, () {
      super.bytesImage = value;
    });
  }

  final _$titleAtom = Atom(name: '_NewMediaWebStoreBase.title');

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  final _$descriptionAtom = Atom(name: '_NewMediaWebStoreBase.description');

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  final _$urlAtom = Atom(name: '_NewMediaWebStoreBase.url');

  @override
  String get url {
    _$urlAtom.reportRead();
    return super.url;
  }

  @override
  set url(String value) {
    _$urlAtom.reportWrite(value, super.url, () {
      super.url = value;
    });
  }

  final _$_NewMediaWebStoreBaseActionController =
      ActionController(name: '_NewMediaWebStoreBase');

  @override
  dynamic setImage(File image) {
    final _$actionInfo = _$_NewMediaWebStoreBaseActionController.startAction(
        name: '_NewMediaWebStoreBase.setImage');
    try {
      return super.setImage(image);
    } finally {
      _$_NewMediaWebStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setBytesImage(dynamic bytesImage) {
    final _$actionInfo = _$_NewMediaWebStoreBaseActionController.startAction(
        name: '_NewMediaWebStoreBase.setBytesImage');
    try {
      return super.setBytesImage(bytesImage);
    } finally {
      _$_NewMediaWebStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setProperty(
      {String? title, String? description, String? url, String? urlMin}) {
    final _$actionInfo = _$_NewMediaWebStoreBaseActionController.startAction(
        name: '_NewMediaWebStoreBase.setProperty');
    try {
      return super.setProperty(
          title: title, description: description, url: url, urlMin: urlMin);
    } finally {
      _$_NewMediaWebStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
image: ${image},
bytesImage: ${bytesImage},
title: ${title},
description: ${description},
url: ${url},
fieldsFill: ${fieldsFill}
    ''';
  }
}
