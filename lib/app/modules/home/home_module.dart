import 'package:arbo/app/modules/home/controllers/map_home_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/home_store.dart';
import 'views/home_page.dart';

class HomeModule extends Module {

  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => HomeStore(
        showButtonMenu: kIsWeb ? false : (i.args!.data == null ? true : i.args!.data),
      ),
    ),
    Bind.lazySingleton((i) => MapHomeStore()),
  ];  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
  ];

}
