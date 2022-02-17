// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learn_read_web_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LearnReadWebStore on _LearnReadWebStoreBase, Store {
  final _$mediasReadAtom = Atom(name: '_LearnReadWebStoreBase.mediasRead');

  @override
  ObservableList<Midia>? get mediasRead {
    _$mediasReadAtom.reportRead();
    return super.mediasRead;
  }

  @override
  set mediasRead(ObservableList<Midia>? value) {
    _$mediasReadAtom.reportWrite(value, super.mediasRead, () {
      super.mediasRead = value;
    });
  }

  final _$_getMediasAsyncAction =
      AsyncAction('_LearnReadWebStoreBase._getMedias');

  @override
  Future _getMedias() {
    return _$_getMediasAsyncAction.run(() => super._getMedias());
  }

  final _$deleteMediaAsyncAction =
      AsyncAction('_LearnReadWebStoreBase.deleteMedia');

  @override
  Future<dynamic> deleteMedia(Midia media, BuildContext context) {
    return _$deleteMediaAsyncAction
        .run(() => super.deleteMedia(media, context));
  }

  final _$newMediaAsyncAction = AsyncAction('_LearnReadWebStoreBase.newMedia');

  @override
  Future<dynamic> newMedia(BuildContext context) {
    return _$newMediaAsyncAction.run(() => super.newMedia(context));
  }

  @override
  String toString() {
    return '''
mediasRead: ${mediasRead}
    ''';
  }
}
