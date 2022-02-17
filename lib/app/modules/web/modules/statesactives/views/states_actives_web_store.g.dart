// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'states_actives_web_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StatesActivesWebStore on _StatesActivesWebStoreBase, Store {
  final _$statesAtom = Atom(name: '_StatesActivesWebStoreBase.states');

  @override
  ObservableList<EstadoAtivo>? get states {
    _$statesAtom.reportRead();
    return super.states;
  }

  @override
  set states(ObservableList<EstadoAtivo>? value) {
    _$statesAtom.reportWrite(value, super.states, () {
      super.states = value;
    });
  }

  final _$_getStatesAsyncAction =
      AsyncAction('_StatesActivesWebStoreBase._getStates');

  @override
  Future _getStates() {
    return _$_getStatesAsyncAction.run(() => super._getStates());
  }

  @override
  String toString() {
    return '''
states: ${states}
    ''';
  }
}
