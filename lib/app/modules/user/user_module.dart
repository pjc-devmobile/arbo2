import 'package:arbo/app/modules/user/controllers/user_store.dart';
import 'package:arbo/app/modules/user/views/user_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UserModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => UserStore(i.args!.data)),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => UserPage()),
  ];
}
