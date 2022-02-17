import 'package:arbo/app/modules/web/modules/learn/views/newmedia/new_media_web_store.dart';
import 'package:arbo/app/modules/web/modules/learn/views/read/learn_read_web_store.dart';
import 'package:arbo/app/modules/web/modules/learn/views/watch/learn_watch_web_page.dart';
import 'package:arbo/app/modules/web/modules/learn/views/watch/learn_watch_web_store.dart';
import 'package:arbo/app/router_list.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'views/read/learn_read_web_page.dart';

class LearnWebModule extends Module {

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LearnReadWebStore()),
    Bind.lazySingleton((i) => LearnWatchWebStore()),
    Bind.lazySingleton((i) => NewMediaWebStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(RoutersWeb.LEARN_WATCH, child: (_, args) => LearnWatchWebPage()),
    ChildRoute(RoutersWeb.LEARN_READ, child: (_, args) => LearnReadWebPage()),
  ];

}
