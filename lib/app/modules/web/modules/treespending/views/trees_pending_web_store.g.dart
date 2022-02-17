// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trees_pending_web_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TreesPendingWebStore on _TreesPendingWebStoreBase, Store {
  final _$treesAtom = Atom(name: '_TreesPendingWebStoreBase.trees');

  @override
  ObservableList<Arvore>? get trees {
    _$treesAtom.reportRead();
    return super.trees;
  }

  @override
  set trees(ObservableList<Arvore>? value) {
    _$treesAtom.reportWrite(value, super.trees, () {
      super.trees = value;
    });
  }

  final _$_getTreesAsyncAction =
      AsyncAction('_TreesPendingWebStoreBase._getTrees');

  @override
  Future _getTrees() {
    return _$_getTreesAsyncAction.run(() => super._getTrees());
  }

  final _$declineAsyncAction = AsyncAction('_TreesPendingWebStoreBase.decline');

  @override
  Future<dynamic> decline(Arvore tree, BuildContext context) {
    return _$declineAsyncAction.run(() => super.decline(tree, context));
  }

  final _$approveAsyncAction = AsyncAction('_TreesPendingWebStoreBase.approve');

  @override
  Future<dynamic> approve(Arvore tree, BuildContext context) {
    return _$approveAsyncAction.run(() => super.approve(tree, context));
  }

  @override
  String toString() {
    return '''
trees: ${trees}
    ''';
  }
}
