import 'package:arbo/app/modules/web/modules/sign/views/sign_in_user_password_web_page.dart';
import 'package:arbo/app/modules/web/modules/sign/views/sign_in_user_password_web_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignWebModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => SignInUserPasswordWebStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => SignInUserPasswordWebPage(),
    ),
  ];
}
