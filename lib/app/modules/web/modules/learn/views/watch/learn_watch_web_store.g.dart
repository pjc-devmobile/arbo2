// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learn_watch_web_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LearnWatchWebStore on _LearnWatchWebStoreBase, Store {
  final _$mediasWatchAtom = Atom(name: '_LearnWatchWebStoreBase.mediasWatch');

  @override
  ObservableList<Midia>? get mediasWatch {
    _$mediasWatchAtom.reportRead();
    return super.mediasWatch;
  }

  @override
  set mediasWatch(ObservableList<Midia>? value) {
    _$mediasWatchAtom.reportWrite(value, super.mediasWatch, () {
      super.mediasWatch = value;
    });
  }

  final _$_getMediasAsyncAction =
      AsyncAction('_LearnWatchWebStoreBase._getMedias');

  @override
  Future _getMedias() {
    return _$_getMediasAsyncAction.run(() => super._getMedias());
  }

  final _$deleteMediaAsyncAction =
      AsyncAction('_LearnWatchWebStoreBase.deleteMedia');

  @override
  Future<dynamic> deleteMedia(Midia media, BuildContext context) {
    return _$deleteMediaAsyncAction
        .run(() => super.deleteMedia(media, context));
  }

  final _$newMediaAsyncAction = AsyncAction('_LearnWatchWebStoreBase.newMedia');

  @override
  Future<dynamic> newMedia(BuildContext context) {
    return _$newMediaAsyncAction.run(() => super.newMedia(context));
  }

  @override
  String toString() {
    return '''
mediasWatch: ${mediasWatch}
    ''';
  }
}
