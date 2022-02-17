// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_pix_boleto_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PayPixBoletoStore on _PayPixBoletoStoreBase, Store {
  final _$responseTransactionAtom =
      Atom(name: '_PayPixBoletoStoreBase.responseTransaction');

  @override
  dynamic get responseTransaction {
    _$responseTransactionAtom.reportRead();
    return super.responseTransaction;
  }

  @override
  set responseTransaction(dynamic value) {
    _$responseTransactionAtom.reportWrite(value, super.responseTransaction, () {
      super.responseTransaction = value;
    });
  }

  final _$_PayPixBoletoStoreBaseActionController =
      ActionController(name: '_PayPixBoletoStoreBase');

  @override
  void pay(BuildContext context) {
    final _$actionInfo = _$_PayPixBoletoStoreBaseActionController.startAction(
        name: '_PayPixBoletoStoreBase.pay');
    try {
      return super.pay(context);
    } finally {
      _$_PayPixBoletoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
responseTransaction: ${responseTransaction}
    ''';
  }
}
