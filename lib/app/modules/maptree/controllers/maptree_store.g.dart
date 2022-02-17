// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maptree_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MapTreeStore on _MapTreeStoreBase, Store {
  Computed<dynamic>? _$showingTabBarComputed;

  @override
  dynamic get showingTabBar =>
      (_$showingTabBarComputed ??= Computed<dynamic>(() => super.showingTabBar,
              name: '_MapTreeStoreBase.showingTabBar'))
          .value;
  Computed<bool>? _$fieldsFillComputed;

  @override
  bool get fieldsFill =>
      (_$fieldsFillComputed ??= Computed<bool>(() => super.fieldsFill,
              name: '_MapTreeStoreBase.fieldsFill'))
          .value;

  final _$imageFileAtom = Atom(name: '_MapTreeStoreBase.imageFile');

  @override
  File? get imageFile {
    _$imageFileAtom.reportRead();
    return super.imageFile;
  }

  @override
  set imageFile(File? value) {
    _$imageFileAtom.reportWrite(value, super.imageFile, () {
      super.imageFile = value;
    });
  }

  final _$nameAtom = Atom(name: '_MapTreeStoreBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$descriptionAtom = Atom(name: '_MapTreeStoreBase.description');

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  final _$producingAtom = Atom(name: '_MapTreeStoreBase.producing');

  @override
  bool get producing {
    _$producingAtom.reportRead();
    return super.producing;
  }

  @override
  set producing(bool value) {
    _$producingAtom.reportWrite(value, super.producing, () {
      super.producing = value;
    });
  }

  final _$monthStartAtom = Atom(name: '_MapTreeStoreBase.monthStart');

  @override
  int? get monthStart {
    _$monthStartAtom.reportRead();
    return super.monthStart;
  }

  @override
  set monthStart(int? value) {
    _$monthStartAtom.reportWrite(value, super.monthStart, () {
      super.monthStart = value;
    });
  }

  final _$monthEndAtom = Atom(name: '_MapTreeStoreBase.monthEnd');

  @override
  int? get monthEnd {
    _$monthEndAtom.reportRead();
    return super.monthEnd;
  }

  @override
  set monthEnd(int? value) {
    _$monthEndAtom.reportWrite(value, super.monthEnd, () {
      super.monthEnd = value;
    });
  }

  final _$monthStartNameAtom = Atom(name: '_MapTreeStoreBase.monthStartName');

  @override
  String? get monthStartName {
    _$monthStartNameAtom.reportRead();
    return super.monthStartName;
  }

  @override
  set monthStartName(String? value) {
    _$monthStartNameAtom.reportWrite(value, super.monthStartName, () {
      super.monthStartName = value;
    });
  }

  final _$monthEndNameAtom = Atom(name: '_MapTreeStoreBase.monthEndName');

  @override
  String? get monthEndName {
    _$monthEndNameAtom.reportRead();
    return super.monthEndName;
  }

  @override
  set monthEndName(String? value) {
    _$monthEndNameAtom.reportWrite(value, super.monthEndName, () {
      super.monthEndName = value;
    });
  }

  final _$markersAtom = Atom(name: '_MapTreeStoreBase.markers');

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
      AsyncAction('_MapTreeStoreBase.updateMarkers');

  @override
  Future updateMarkers() {
    return _$updateMarkersAsyncAction.run(() => super.updateMarkers());
  }

  final _$_MapTreeStoreBaseActionController =
      ActionController(name: '_MapTreeStoreBase');

  @override
  dynamic setProperty(
      {File? image,
      String? name,
      String? description,
      bool? producing,
      int? monthStart,
      int? monthEnd,
      String? monthStartName,
      String? monthEndName}) {
    final _$actionInfo = _$_MapTreeStoreBaseActionController.startAction(
        name: '_MapTreeStoreBase.setProperty');
    try {
      return super.setProperty(
          image: image,
          name: name,
          description: description,
          producing: producing,
          monthStart: monthStart,
          monthEnd: monthEnd,
          monthStartName: monthStartName,
          monthEndName: monthEndName);
    } finally {
      _$_MapTreeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
imageFile: ${imageFile},
name: ${name},
description: ${description},
producing: ${producing},
monthStart: ${monthStart},
monthEnd: ${monthEnd},
monthStartName: ${monthStartName},
monthEndName: ${monthEndName},
markers: ${markers},
showingTabBar: ${showingTabBar},
fieldsFill: ${fieldsFill}
    ''';
  }
}
