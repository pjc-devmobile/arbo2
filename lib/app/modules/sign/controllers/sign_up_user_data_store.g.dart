// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_user_data_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpUserDataStore on _SignUpUserDataStoreBase, Store {
  final _$acceptTermsAtom = Atom(name: '_SignUpUserDataStoreBase.acceptTerms');

  @override
  bool get acceptTerms {
    _$acceptTermsAtom.reportRead();
    return super.acceptTerms;
  }

  @override
  set acceptTerms(bool value) {
    _$acceptTermsAtom.reportWrite(value, super.acceptTerms, () {
      super.acceptTerms = value;
    });
  }

  final _$_SignUpUserDataStoreBaseActionController =
      ActionController(name: '_SignUpUserDataStoreBase');

  @override
  dynamic setAcceptTerms(dynamic at) {
    final _$actionInfo = _$_SignUpUserDataStoreBaseActionController.startAction(
        name: '_SignUpUserDataStoreBase.setAcceptTerms');
    try {
      return super.setAcceptTerms(at);
    } finally {
      _$_SignUpUserDataStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
acceptTerms: ${acceptTerms}
    ''';
  }
}
