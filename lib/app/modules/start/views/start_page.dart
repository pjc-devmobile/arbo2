import 'package:arbo/app/modules/start/controllers/start_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils.dart';
import 'package:arbo/app/shared/responsive_values.dart';

import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:utils/utils/constants/colors.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends ModularState<StartPage, StartStore> with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    tabController.addListener(() {
      controller.setCurrentIndex(tabController.index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(child: buildTabs()),
          Expanded(
            child: RouterOutlet(),
          ),
        ],
      ),
    );
  }

  Widget buildTabs() {
    return Observer(builder: (_) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        child: Padding(
          padding: EdgeInsets.only(top: Responsive.to.prefPaddinHeight / 2),
          child: SingleChildScrollView(
            child: TabBar(
              controller: tabController,
              onTap: (index) {
                if (index != 1) controller.toggleShowingTabBar();
                controller.switchTab(index);
              },
              tabs: <Widget>[
                Tab(
                  icon: CircleAvatar(
                    backgroundColor: controller.currentIndex == 0
                        ? ColorsConfig.primaryColor
                        : ColorsConfig.grey.withOpacity(0.5),
                    child: Icon(
                      Icons.home,
                      color: ColorsConfig.lightColor,
                    ),
                  ),
                  text:S.to.inicio,
                ),
                Tab(
                  icon: CircleAvatar(
                    backgroundColor: controller.currentIndex == 1
                        ? ColorsConfig.primaryColor
                        : ColorsConfig.grey.withOpacity(0.5),
                    child: Icon(
                      Icons.person,
                      color: ColorsConfig.lightColor,
                    ),
                  ),
                  text:S.to.perfil,
                ),
                Tab(
                  icon: CircleAvatar(
                    backgroundColor: controller.currentIndex == 2
                        ? ColorsConfig.primaryColor
                        : ColorsConfig.grey.withOpacity(0.5),
                    child: Icon(
                      Icons.add_location_alt_sharp,
                      color: ColorsConfig.lightColor,
                    ),
                  ),
                  text:S.to.mapear,
                ),
                Tab(
                  icon: CircleAvatar(
                    backgroundColor: controller.currentIndex == 3
                        ? ColorsConfig.primaryColor
                        : ColorsConfig.grey.withOpacity(0.5),
                    child: Icon(
                      Icons.menu_book,
                      color: ColorsConfig.lightColor,
                    ),
                  ),
                  text:S.to.aprenda,
                ),
                Tab(
                  icon: CircleAvatar(
                    backgroundColor: controller.currentIndex == 4
                        ? ColorsConfig.primaryColor
                        : ColorsConfig.grey.withOpacity(0.5),
                    child: Icon(
                      FlutterIcons.donate_faw5s,
                      color: ColorsConfig.lightColor,
                    ),
                  ),
                  text:S.to.doar,
                ),
              ],
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.black38,
              indicatorColor: Colors.transparent,
            ),
          ),
        ),
        height: controller.showingTabBar ? 85 : 0,
        width: Responsive.to.width,
      );
    });
  }
}
