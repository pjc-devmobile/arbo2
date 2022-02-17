// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cities_actives_web_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CitiesActivesWebStore on _CitiesActivesWebStoreBase, Store {
  final _$citiesAtom = Atom(name: '_CitiesActivesWebStoreBase.cities');

  @override
  ObservableList<CidadeAtiva>? get cities {
    _$citiesAtom.reportRead();
    return super.cities;
  }

  @override
  set cities(ObservableList<CidadeAtiva>? value) {
    _$citiesAtom.reportWrite(value, super.cities, () {
      super.cities = value;
    });
  }

  final _$_getCitiesAsyncAction =
      AsyncAction('_CitiesActivesWebStoreBase._getCities');

  @override
  Future _getCities() {
    return _$_getCitiesAsyncAction.run(() => super._getCities());
  }

  @override
  String toString() {
    return '''
cities: ${cities}
    ''';
  }
}
