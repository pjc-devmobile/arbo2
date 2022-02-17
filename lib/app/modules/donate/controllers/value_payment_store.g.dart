// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value_payment_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ValuePaymentStore on _ValuePaymentStoreBase, Store {
  final _$valueAtom = Atom(name: '_ValuePaymentStoreBase.value');

  @override
  double get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(double value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  final _$_ValuePaymentStoreBaseActionController =
      ActionController(name: '_ValuePaymentStoreBase');

  @override
  void setValue(double v) {
    final _$actionInfo = _$_ValuePaymentStoreBaseActionController.startAction(
        name: '_ValuePaymentStoreBase.setValue');
    try {
      return super.setValue(v);
    } finally {
      _$_ValuePaymentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
