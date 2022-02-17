import 'package:arbo/app/firebase_messaging/firebase_cloud_messaging_wapper.dart';
import 'package:arbo/app/modules/core/repositories/app_repository.dart';
import 'package:arbo/app/modules/core/repositories/usuario_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

import '../models/app.dart';
import '../models/usuario.dart';

part 'app_store.g.dart';

class AppStore = _AppStoreBase with _$AppStore;

abstract class _AppStoreBase with Store {
  static final AppRepository _appRepository = AppRepository();
  final UsuarioRepository _usuarioRepository = UsuarioRepository();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? firebaseUser;

  @observable
  Usuario? currentUsuario;

  App? _appInfo;

  ///Utiliado na splash e login
  Future<Usuario?> getCurrentUsuario() async {
    firebaseUser = _auth.currentUser;

    if (firebaseUser == null) return null;

    ///Current usuário
    var currentUsuario = await _usuarioRepository.getUserById(firebaseUser!.uid).then(
          (value) => value.data() == null ? null : Usuario.fromJson(value.data()!),
        );

    setCurrentUsuario(currentUsuario);

    ///Listener usuario
    _usuarioRepository.getCurrentUsuarioListener(firebaseUser!.uid).listen(
      (event) {
        if (event.exists) setCurrentUsuario(Usuario.fromJson(event.data()!));
      },
    );

    return currentUsuario;
  }

  @action
  setCurrentUsuario(Usuario? usr) {
    currentUsuario = usr;
  }

  Future<App> get appInfo async {
    _appInfo = await _appRepository.getAppInfo().then((value) {
      return App.fromJson(value.data()!);
    });

    return _appInfo!;
  }

  App get appInfoSync => _appInfo!;

  Future signOut() async {
    String token = await FirebaseCloudMessagagingWapper.getToken();
    if (!kIsWeb)
      await _appRepository.removeToken(currentUsuario!.id, token);

    return _auth.signOut().then((value) {
      firebaseUser = null;
      currentUsuario = null;
    });
  }

  ///Tokens de notificações push
  updateToken(String? token) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    if (token == null) token = await FirebaseCloudMessagagingWapper.getToken();

    _appRepository.saveToken(user.uid, token!);
  }
}
