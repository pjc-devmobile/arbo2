import 'package:arbo/app/modules/web/modules/statesactives/views/states_actives_web_page.dart';
import 'package:arbo/app/modules/web/modules/statesactives/views/states_actives_web_store.dart';
import 'package:arbo/app/router_list.dart';
import 'package:flutter_modular/flutter_modular.dart';

class StatesActivesWebModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => StatesActivesWebStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(RoutersWeb.STATES_ACTIVE, child: (_, args) => StatesActivesWebPage()),
  ];
}
