import 'package:arbo/app/modules/core/models/info_usuario.dart';
import 'package:arbo/app/modules/core/models/usuario.dart';
import 'package:arbo/app/modules/core/repositories/usuario_repository.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  
  final UsuarioRepository _repository = UsuarioRepository();
  final InfoUsuario infoUser;

  @observable
  Usuario? user;
  
  _UserStoreBase(this.infoUser){
   _repository.getUserById(infoUser.id).then((value) {
     _setUser(Usuario.fromJson(value.data()!));
   });
  }

  @action
  _setUser(Usuario u) => user = u;
}
