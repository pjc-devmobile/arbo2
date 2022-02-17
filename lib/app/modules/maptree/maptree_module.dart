import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/maptree_store.dart';
import 'views/maptree_page.dart';

class MapTreeModule extends Module {

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MapTreeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => MapTreePage()),
  ];
}
