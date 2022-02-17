import 'package:arbo/app/modules/web/modules/treespending/views/trees_pending_web_page.dart';
import 'package:arbo/app/modules/web/modules/treespending/views/trees_pending_web_store.dart';
import 'package:arbo/app/router_list.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TreesPendingWebModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => TreesPendingWebStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(RoutersWeb.TREE_PENDING, child: (_, args) => TreesPendingWebPage()),
  ];
}
