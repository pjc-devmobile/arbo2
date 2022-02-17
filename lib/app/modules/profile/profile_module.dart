import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/profile_store.dart';
import 'views/profile_page.dart';

class ProfileModule extends Module {

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ProfileStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => ProfilePage()),
  ];
}
