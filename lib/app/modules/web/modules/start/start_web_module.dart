import 'package:arbo/app/modules/core/controllers/app_store.dart';
import 'package:arbo/app/modules/core/models/usuario.dart';
import 'package:arbo/app/modules/home/home_module.dart';
import 'package:arbo/app/modules/start/controllers/start_store.dart';
import 'package:arbo/app/modules/web/modules/citiesactives/cities_actives_web_module.dart';
import 'package:arbo/app/modules/web/modules/learn/learn_web_module.dart';
import 'package:arbo/app/modules/web/modules/start/views/start_web_page.dart';
import 'package:arbo/app/modules/web/modules/statesactives/states_actives_web_module.dart';
import 'package:arbo/app/modules/web/modules/treespending/trees_pending_web_module.dart';
import 'package:arbo/app/modules/web/modules/users/users_module.dart';
import 'package:arbo/app/router_list.dart';
import 'package:flutter_modular/flutter_modular.dart';

class StartWebModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => StartStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => StartWebPage(),
      children: [
        ModuleRoute(HomeRouters.HOME, module: HomeModule()),
        ModuleRoute(
          RoutersWeb.TREE_PENDING,
          module: TreesPendingWebModule(),
        ),
        ModuleRoute(
          RoutersWeb.STATES_ACTIVE,
          module: StatesActivesWebModule(),
        ),
        ModuleRoute(
          RoutersWeb.CITIES_ACTIVE,
          module: CitiesActivesWebModule(),
        ),
        ModuleRoute(
          RoutersWeb.LEARN,
          module: LearnWebModule(),
          guards: [UserAdmGuard()],
        ),
        ModuleRoute(
          RoutersWeb.USERS,
          module: UsersWebModule(),
          guards: [UserAdmGuard()],
        ),
      ],
    ),
  ];
}

class UserAdmGuard implements RouteGuard {
  @override
  Future<bool> canActivate(String url, ModularRoute route) async {
    return Modular.get<AppStore>().currentUsuario!.tipoUsuario == TipoUsuario.ADM;
  }

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
