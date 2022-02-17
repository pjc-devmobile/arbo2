import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/learn_store.dart';
import 'views/learn_page.dart';

class LearnModule extends Module {

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LearnStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => LearnPage()),
  ];

}
