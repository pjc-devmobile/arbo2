// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StartStore on _StartStoreBase, Store {
  final _$currentIndexAtom = Atom(name: '_StartStoreBase.currentIndex');

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  final _$showingTabBarAtom = Atom(name: '_StartStoreBase.showingTabBar');

  @override
  bool get showingTabBar {
    _$showingTabBarAtom.reportRead();
    return super.showingTabBar;
  }

  @override
  set showingTabBar(bool value) {
    _$showingTabBarAtom.reportWrite(value, super.showingTabBar, () {
      super.showingTabBar = value;
    });
  }

  final _$_StartStoreBaseActionController =
      ActionController(name: '_StartStoreBase');

  @override
  dynamic setCurrentIndex(int index) {
    final _$actionInfo = _$_StartStoreBaseActionController.startAction(
        name: '_StartStoreBase.setCurrentIndex');
    try {
      return super.setCurrentIndex(index);
    } finally {
      _$_StartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic toggleShowingTabBar() {
    final _$actionInfo = _$_StartStoreBaseActionController.startAction(
        name: '_StartStoreBase.toggleShowingTabBar');
    try {
      return super.toggleShowingTabBar();
    } finally {
      _$_StartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void switchTab(int index) {
    final _$actionInfo = _$_StartStoreBaseActionController.startAction(
        name: '_StartStoreBase.switchTab');
    try {
      return super.switchTab(index);
    } finally {
      _$_StartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentIndex: ${currentIndex},
showingTabBar: ${showingTabBar}
    ''';
  }
}
