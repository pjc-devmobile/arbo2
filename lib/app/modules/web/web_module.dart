import 'package:arbo/app/modules/web/modules/start/views/start_web_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../router_list.dart';
import 'modules/sign/sign_web_module.dart';
import 'modules/start/start_web_module.dart';

class WebModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => StartWebStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      RoutersWeb.SIGN_IN,
      module: SignWebModule(),
    ),
    ModuleRoute(
      RoutersWeb.START,
      module: StartWebModule(),
    ),
  ];
}
