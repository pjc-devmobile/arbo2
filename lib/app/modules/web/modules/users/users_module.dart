import 'package:arbo/app/modules/web/modules/users/views/users_page.dart';
import 'package:arbo/app/modules/web/modules/users/views/users_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UsersWebModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => UsersStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => UsersPage()),
  ];
}
