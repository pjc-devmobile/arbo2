import 'package:arbo/app/modules/core/controllers/app_store.dart';
import 'package:arbo/app/modules/core/controllers/splash_store.dart';
import 'package:arbo/app/modules/core/views/splash_page.dart';
import 'package:arbo/app/modules/home/home_module.dart';
import 'package:arbo/app/modules/sign/sign_module.dart';
import 'package:arbo/app/modules/start/start_module.dart';
import 'package:arbo/app/modules/user/user_module.dart';
import 'package:arbo/app/modules/web/controllers/splash_web_store.dart';
import 'package:arbo/app/modules/web/views/splash_web_page.dart';
import 'package:arbo/app/modules/web/web_module.dart';
import 'package:arbo/app/router_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AppStore()),
    Bind.lazySingleton((i) => SplashStore()),

    ///Web
    Bind.lazySingleton((i) => SplashWebStore()),
  ];

  ///TESTEEEEEEEEE COM WEB REMOVER O '!'
  @override
  final List<ModularRoute> routes = kIsWeb ? _routersWeb : _routersMobile;

  static List<ModularRoute> get _routersMobile {
    return[
      ChildRoute(
        RouterList.SPLASH,
        child: (_, args) => SplashPage(),
      ),

      ///Modulos
      ModuleRoute(
        RouterList.SIGNIN_MODULE,
        module: SignModule(),
      ),
      ModuleRoute(
        RouterList.START_MODULE,
        module: StartModule(),
      ),
      ModuleRoute(
        RouterList.USER_MODULE,
        module: UserModule(),
      ),
    ];
  }

  static List<ModularRoute> get _routersWeb{
    return [
      ChildRoute(
        RouterList.SPLASH,
        child: (_, args) => SplashWebPage(),
      ),
      ModuleRoute(
        RouterList.WEB_MODULE,
        module: WebModule(),
      ),
      ModuleRoute(
        RouterList.USER_MODULE,
        module: UserModule(),
      ),
      ModuleRoute(
        RouterList.MAP_MODULE,
        module: HomeModule(),
      ),
    ];
  }
}
