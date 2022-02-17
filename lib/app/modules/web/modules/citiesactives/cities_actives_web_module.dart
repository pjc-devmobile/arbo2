import 'package:arbo/app/modules/web/modules/citiesactives/views/cities_actives_web_page.dart';
import 'package:arbo/app/modules/web/modules/citiesactives/views/cities_actives_web_store.dart';
import 'package:arbo/app/router_list.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CitiesActivesWebModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CitiesActivesWebStore(state: i.args!.data)),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(RoutersWeb.CITIES_ACTIVE, child: (_, args) => CitiesActivesWebPage()),
  ];
}
