// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MapHomeStore on _MapHomeStoreBase, Store {
  final _$markersAtom = Atom(name: '_MapHomeStoreBase.markers');

  @override
  Set<Marker>? get markers {
    _$markersAtom.reportRead();
    return super.markers;
  }

  @override
  set markers(Set<Marker>? value) {
    _$markersAtom.reportWrite(value, super.markers, () {
      super.markers = value;
    });
  }

  final _$updateMarkersAsyncAction =
      AsyncAction('_MapHomeStoreBase.updateMarkers');

  @override
  Future updateMarkers() {
    return _$updateMarkersAsyncAction.run(() => super.updateMarkers());
  }

  @override
  String toString() {
    return '''
markers: ${markers}
    ''';
  }
}
