// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UsersStore on _UsersStoreBase, Store {
  final _$usersVoluntaryAtom = Atom(name: '_UsersStoreBase.usersVoluntary');

  @override
  ObservableList<Usuario>? get usersVoluntary {
    _$usersVoluntaryAtom.reportRead();
    return super.usersVoluntary;
  }

  @override
  set usersVoluntary(ObservableList<Usuario>? value) {
    _$usersVoluntaryAtom.reportWrite(value, super.usersVoluntary, () {
      super.usersVoluntary = value;
    });
  }

  final _$allUsersAtom = Atom(name: '_UsersStoreBase.allUsers');

  @override
  ObservableList<Usuario>? get allUsers {
    _$allUsersAtom.reportRead();
    return super.allUsers;
  }

  @override
  set allUsers(ObservableList<Usuario>? value) {
    _$allUsersAtom.reportWrite(value, super.allUsers, () {
      super.allUsers = value;
    });
  }

  final _$showingOptionsOfferAtom =
      Atom(name: '_UsersStoreBase.showingOptionsOffer');

  @override
  ObservableList<int> get showingOptionsOffer {
    _$showingOptionsOfferAtom.reportRead();
    return super.showingOptionsOffer;
  }

  @override
  set showingOptionsOffer(ObservableList<int> value) {
    _$showingOptionsOfferAtom.reportWrite(value, super.showingOptionsOffer, () {
      super.showingOptionsOffer = value;
    });
  }

  final _$getAllUsersAsyncAction = AsyncAction('_UsersStoreBase.getAllUsers');

  @override
  Future<dynamic> getAllUsers() {
    return _$getAllUsersAsyncAction.run(() => super.getAllUsers());
  }

  final _$getUsersVoluntariesAsyncAction =
      AsyncAction('_UsersStoreBase.getUsersVoluntaries');

  @override
  Future<dynamic> getUsersVoluntaries() {
    return _$getUsersVoluntariesAsyncAction
        .run(() => super.getUsersVoluntaries());
  }

  final _$becomeVoluntaryAsyncAction =
      AsyncAction('_UsersStoreBase.becomeVoluntary');

  @override
  Future<dynamic> becomeVoluntary(BuildContext context, Usuario user) {
    return _$becomeVoluntaryAsyncAction
        .run(() => super.becomeVoluntary(context, user));
  }

  final _$becomeUserAsyncAction = AsyncAction('_UsersStoreBase.becomeUser');

  @override
  Future<dynamic> becomeUser(BuildContext context, Usuario user) {
    return _$becomeUserAsyncAction.run(() => super.becomeUser(context, user));
  }

  @override
  String toString() {
    return '''
usersVoluntary: ${usersVoluntary},
allUsers: ${allUsers},
showingOptionsOffer: ${showingOptionsOffer}
    ''';
  }
}
