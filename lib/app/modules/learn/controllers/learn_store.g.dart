// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learn_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LearnStore on _LearnStoreBase, Store {
  Computed<dynamic>? _$showingTabBarComputed;

  @override
  dynamic get showingTabBar =>
      (_$showingTabBarComputed ??= Computed<dynamic>(() => super.showingTabBar,
              name: '_LearnStoreBase.showingTabBar'))
          .value;

  final _$mediasWatchAtom = Atom(name: '_LearnStoreBase.mediasWatch');

  @override
  List<Midia>? get mediasWatch {
    _$mediasWatchAtom.reportRead();
    return super.mediasWatch;
  }

  @override
  set mediasWatch(List<Midia>? value) {
    _$mediasWatchAtom.reportWrite(value, super.mediasWatch, () {
      super.mediasWatch = value;
    });
  }

  final _$mediasReadAtom = Atom(name: '_LearnStoreBase.mediasRead');

  @override
  List<Midia>? get mediasRead {
    _$mediasReadAtom.reportRead();
    return super.mediasRead;
  }

  @override
  set mediasRead(List<Midia>? value) {
    _$mediasReadAtom.reportWrite(value, super.mediasRead, () {
      super.mediasRead = value;
    });
  }

  final _$_getMediasAsyncAction = AsyncAction('_LearnStoreBase._getMedias');

  @override
  Future _getMedias() {
    return _$_getMediasAsyncAction.run(() => super._getMedias());
  }

  @override
  String toString() {
    return '''
mediasWatch: ${mediasWatch},
mediasRead: ${mediasRead},
showingTabBar: ${showingTabBar}
    ''';
  }
}
