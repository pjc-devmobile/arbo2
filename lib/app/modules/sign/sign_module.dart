import 'package:arbo/app/modules/sign/controllers/sign_in_user_password_store.dart';
import 'package:arbo/app/modules/sign/controllers/sign_type_store.dart';
import 'package:arbo/app/modules/sign/controllers/sign_up_user_data_store.dart';
import 'package:arbo/app/modules/sign/views/sign_in_user_password_page.dart';
import 'package:arbo/app/modules/sign/views/sign_type_page.dart';
import 'package:arbo/app/modules/sign/views/sign_up_user_data_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../router_list.dart';

class SignModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => SignTypeStore()),
    Bind.factory((i) => SignInUserPasswordStore()),
    Bind.factory((i) => SignUpUserDataStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => SignTypePage(),),
    ChildRoute(SignRouters.SIGN_IN_USER_PASSWORD, child: (_, args) => SignInUserPasswordPage(),),
    ChildRoute(SignRouters.SIGN_UP_USER_DATA, child: (_, args) => SignUpUserDataPage()),
  ];

}