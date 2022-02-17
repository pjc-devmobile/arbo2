// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on _AppStoreBase, Store {
  final _$currentUsuarioAtom = Atom(name: '_AppStoreBase.currentUsuario');

  @override
  Usuario? get currentUsuario {
    _$currentUsuarioAtom.reportRead();
    return super.currentUsuario;
  }

  @override
  set currentUsuario(Usuario? value) {
    _$currentUsuarioAtom.reportWrite(value, super.currentUsuario, () {
      super.currentUsuario = value;
    });
  }

  final _$_AppStoreBaseActionController =
      ActionController(name: '_AppStoreBase');

  @override
  dynamic setCurrentUsuario(Usuario? usr) {
    final _$actionInfo = _$_AppStoreBaseActionController.startAction(
        name: '_AppStoreBase.setCurrentUsuario');
    try {
      return super.setCurrentUsuario(usr);
    } finally {
      _$_AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentUsuario: ${currentUsuario}
    ''';
  }
}
