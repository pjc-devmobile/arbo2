import 'package:arbo/app/modules/core/controllers/app_store.dart';
import 'package:arbo/app/modules/core/models/usuario.dart';
import 'package:arbo/app/modules/core/repositories/usuario_repository.dart';
import 'package:arbo/app/shared/components/confirm_dialog.dart';
import 'package:arbo/app/shared/components/progress_dialog.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'users_store.g.dart';

class UsersStore = _UsersStoreBase with _$UsersStore;

abstract class _UsersStoreBase with Store implements Disposable {
  final appStore = Modular.get<AppStore>();
  final _repository = UsuarioRepository();

  @observable
  ObservableList<Usuario>? usersVoluntary;

  @observable
  ObservableList<Usuario>? allUsers;

  @observable
  ObservableList<int> showingOptionsOffer = ObservableList.of([]);

  _UsersStoreBase() {
    getAllUsers();
    getUsersVoluntaries();
  }

  @override
  void dispose() {}

  @action
  Future getAllUsers() async {
    final list = await _repository.getUsuarios();
    allUsers = ObservableList.of(list);
  }

  @action
  Future getUsersVoluntaries() async {
    final list = await _repository.getUsuariosPorTipo(TipoUsuario.VOLUNTARIO);
    usersVoluntary = ObservableList.of(list);
  }

  @action
  Future becomeVoluntary(BuildContext context, Usuario user) async {

    bool? confirm = await showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title:S.to.tornarVoluntarioInterrogacao,
        buttonConfirmar:S.to.tornarVoluntario,
        buttonCancelar:S.to.cancelar,
        info:S.to.desejaRealmenteTornarVoluntario.replaceAll("?1", user.pessoa.nomeSobrenome),
      ),
    );

    if (confirm == null || !confirm) return;

    showDialog(
      context: context,
      builder: (context) => ProgressDialog(
        title:S.to.aguarde,
      ),
    );

    user.tipoUsuario = TipoUsuario.VOLUNTARIO;
    await _repository.updateUsuario(user);
    Modular.to.pop();

    allUsers![allUsers!.indexOf(user)] = user;
    allUsers = ObservableList.of(allUsers!.toList());
    if (usersVoluntary == null)
      usersVoluntary = ObservableList.of([user]);
    else
      usersVoluntary!.add(user);
  }

  @action
  Future becomeUser(BuildContext context, Usuario user) async {
    bool? confirm = await showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title:S.to.tornarUsuarioInterrogacao,
        buttonConfirmar:S.to.tornarUsuarioComum,
        buttonCancelar:S.to.cancelar,
        info:S.to.desejaRealmenteTornarUsuario.replaceAll("?1", user.pessoa.nomeSobrenome),
      ),
    );

    if (confirm == null || !confirm) return;

    showDialog(
      context: context,
      builder: (context) => ProgressDialog(
        title:S.to.aguarde,
      ),
    );

    user.tipoUsuario = TipoUsuario.USUARIO;
    await _repository.updateUsuario(user);
    Modular.to.pop();

    if (allUsers != null && allUsers!.contains(user)) {
      allUsers![allUsers!.indexOf(user)] = user;
      allUsers = ObservableList.of(allUsers!.toList());
    }
    if (usersVoluntary!.contains(user)) usersVoluntary!.remove(user);
  }
}
