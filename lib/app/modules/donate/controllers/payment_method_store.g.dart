// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PaymentMethodStore on _PaymentMethodStoreBase, Store {
  final _$methodAtom = Atom(name: '_PaymentMethodStoreBase.method');

  @override
  MetodoPagamento? get method {
    _$methodAtom.reportRead();
    return super.method;
  }

  @override
  set method(MetodoPagamento? value) {
    _$methodAtom.reportWrite(value, super.method, () {
      super.method = value;
    });
  }

  final _$_PaymentMethodStoreBaseActionController =
      ActionController(name: '_PaymentMethodStoreBase');

  @override
  void setPaymentMethod(MetodoPagamento mp) {
    final _$actionInfo = _$_PaymentMethodStoreBaseActionController.startAction(
        name: '_PaymentMethodStoreBase.setPaymentMethod');
    try {
      return super.setPaymentMethod(mp);
    } finally {
      _$_PaymentMethodStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
method: ${method}
    ''';
  }
}
