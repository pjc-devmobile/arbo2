// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileStore on _ProfileStoreBase, Store {
  Computed<dynamic>? _$showingTabBarComputed;

  @override
  dynamic get showingTabBar =>
      (_$showingTabBarComputed ??= Computed<dynamic>(() => super.showingTabBar,
              name: '_ProfileStoreBase.showingTabBar'))
          .value;
  Computed<Usuario>? _$currentUsuarioComputed;

  @override
  Usuario get currentUsuario => (_$currentUsuarioComputed ??= Computed<Usuario>(
          () => super.currentUsuario,
          name: '_ProfileStoreBase.currentUsuario'))
      .value;

  @override
  String toString() {
    return '''
showingTabBar: ${showingTabBar},
currentUsuario: ${currentUsuario}
    ''';
  }
}
