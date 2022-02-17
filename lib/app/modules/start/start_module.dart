import 'package:arbo/app/modules/donate/donate_module.dart';
import 'package:arbo/app/modules/home/home_module.dart';
import 'package:arbo/app/modules/learn/learn_module.dart';
import 'package:arbo/app/modules/maptree/maptree_module.dart';
import 'package:arbo/app/modules/profile/profile_module.dart';
import 'package:arbo/app/modules/start/controllers/start_store.dart';
import 'package:arbo/app/router_list.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'views/start_page.dart';

class StartModule extends Module {

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => StartStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => StartPage(),
      children: [
        ModuleRoute(HomeRouters.HOME, module: HomeModule()),
        ModuleRoute(ProfileRouters.PROFILE, module: ProfileModule()),
        ModuleRoute(MapTreeRouters.MAPTREE, module: MapTreeModule()),
        ModuleRoute(LearnRouters.LEARN, module: LearnModule()),
        ModuleRoute(DonateRouters.DONATE, module: DonateModule()),
      ],
    ),
  ];
}
