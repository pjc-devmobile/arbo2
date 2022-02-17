import 'package:arbo/app/modules/home/views/map_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:utils/utils/constants/colors.dart';

import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/l10n/app_localization.dart';
import '../controllers/home_store.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapHomePage(),
          if (controller.showButtonMenu)
            buildButtonMenu(),
        ],
      ),
    );
  }

  Widget buildButtonMenu() {
    return Observer(builder: (_) {
      if (controller.showingTabBar) return SizedBox();

      return SafeArea(
        child: TextButton(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: ColorsConfig.primaryColor,
                child: Icon(
                  Icons.home,
                  color: ColorsConfig.lightColor,
                ),
              ),
              SizedBox(
                height: Responsive.to.prefPaddinHeight / 2,
              ),
              Text(
               S.to.menu,
                style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor),
              )
            ],
          ),
          onPressed: controller.toggleShowingTabBar,
        ),
      );
    });
  }
}
