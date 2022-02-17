import 'package:arbo/app/router_list.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils.dart';
import 'package:utils/utils/constants/colors.dart';

import '../controllers/donate_store.dart';

class DonatePage extends StatefulWidget {
  @override
  _DonatePageState createState() => _DonatePageState();
}

class _DonatePageState extends ModularState<DonatePage, DonateStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildHead(),
            Padding(
              padding: Responsive.to.prefPaddingSymmetric,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Responsive.to.prefPaddinHeight * 2,
                  ),
                  Text(
                    S.to.jaFizemos.toUpperCase(),
                    style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor),
                  ),
                  buildPlantedTrees(),
                  SizedBox(
                    height: Responsive.to.prefPaddinHeight * 3,
                  ),
                  Text(
                    S.to.tudoIssoComApenas.toUpperCase(),
                    style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor),
                  ),
                  buildDonateTotal(),
                  SizedBox(
                    height: Responsive.to.prefPaddinHeight * 2,
                  ),
                  buildButtonDonate(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildHead() {
    return Container(
      width: Responsive.to.width,
      decoration: BoxDecoration(
          color: ColorsConfig.primaryColor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36), bottomRight: Radius.circular(36))),
      child: Padding(
        padding: Responsive.to.prefPaddingSymmetric,
        child: Stack(
          alignment: Alignment.center,
          children: [
            buildButtonMenu(),
            Text(
              S.to.porqueDoar,
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.lightColor, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtonMenu() {
    return Observer(builder: (_) {
      if (controller.showingTabBar) return SizedBox();

      return TextButton(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: ColorsConfig.lightColor,
                child: Icon(
                  FlutterIcons.donate_faw5s,
                  color: ColorsConfig.primaryColor,
                ),
              ),
              SizedBox(
                height: Responsive.to.prefPaddinHeight / 2,
              ),
              Text(
                S.to.menu,
                style: AppTextTheme.textThemeColorBold(color: ColorsConfig.lightColor),
              )
            ],
          ),
        ),
        onPressed: controller.toggleShowingTabBar,
      );
    });
  }

  Widget buildPlantedTrees() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Árvores plantadass
        SizedBox(
          height: Responsive.to.prefPaddinHeight * 2,
        ),
        Row(
          children: [
            SizedBox(
              width: Responsive.to.prefPaddinWidth,
            ),
            Text(
              controller.app.arvoresPlantadas.toString(),
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.greyDark, fontSize: 32),
            ),
            SizedBox(
              width: Responsive.to.prefPaddinWidth,
            ),
            Expanded(
              child: Center(
                child: Text(
                  S.to.arvoresPlantadas.toUpperCase(),
                  style: AppTextTheme.textThemeColor(color: ColorsConfig.greyDark, fontSize: 18),
                ),
              ),
            ),
            Image.asset(
              "assets/icons/ic_tree.png",
              width: Responsive.to.oneUnitValueWidthScreen,
            ),
          ],
        ),

        ///Cidades
        SizedBox(
          height: Responsive.to.prefPaddinHeight * 2,
        ),
        Row(
          children: [
            SizedBox(
              width: Responsive.to.prefPaddinWidth,
            ),
            Text(
              controller.app.cidadesAtivas.toString(),
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.greyDark, fontSize: 32),
            ),
            SizedBox(
              width: Responsive.to.prefPaddinWidth,
            ),
            Expanded(
              child: Center(
                child: Text(
                  S.to.cidadesAtivas.toUpperCase(),
                  style: AppTextTheme.textThemeColor(color: ColorsConfig.greyDark, fontSize: 18),
                ),
              ),
            ),
            Image.asset(
              "assets/icons/ic_map.png",
              width: Responsive.to.oneUnitValueWidthScreen,
            ),
          ],
        ),

        ///Árvores produzindo
        SizedBox(
          height: Responsive.to.prefPaddinHeight * 2,
        ),
        Row(
          children: [
            SizedBox(
              width: Responsive.to.prefPaddinWidth,
            ),
            Text(
              controller.app.arvoresProduzindo.toString(),
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.greyDark, fontSize: 32),
            ),
            SizedBox(
              width: Responsive.to.prefPaddinWidth,
            ),
            Expanded(
              child: Center(
                child: Text(
                  S.to.arvoresProduzindo.toUpperCase(),
                  style: AppTextTheme.textThemeColor(color: ColorsConfig.greyDark, fontSize: 18),
                ),
              ),
            ),
            Image.asset(
              "assets/icons/ic_tree.png",
              width: Responsive.to.oneUnitValueWidthScreen,
            ),
          ],
        ),

        ///Voluntarios
        SizedBox(
          height: Responsive.to.prefPaddinHeight * 2,
        ),
        Row(
          children: [
            SizedBox(
              width: Responsive.to.prefPaddinWidth,
            ),
            Text(
              controller.app.voluntariosColaborando.toString(),
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.greyDark, fontSize: 32),
            ),
            SizedBox(
              width: Responsive.to.prefPaddinWidth,
            ),
            Expanded(
              child: Center(
                child: Text(
                  S.to.voluntariosColaborando.toUpperCase(),
                  style: AppTextTheme.textThemeColor(color: ColorsConfig.greyDark, fontSize: 18),
                ),
              ),
            ),
            Image.asset(
              "assets/icons/ic_network.png",
              width: Responsive.to.oneUnitValueWidthScreen,
            ),
          ],
        ),

        ///Pessoas impactadas
/*        SizedBox(height: Responsive.to.prefPaddinHeight*2,),
        Row(
          children: [
            SizedBox(width: Responsive.to.prefPaddinWidth,),
            Text(
              controller.app.voluntariosColaborando.toString(),
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.greyDark, fontSize: 32),
            ),
            SizedBox(width: Responsive.to.prefPaddinWidth,),
            Expanded(
              child: Center(
                child: Text(
                 S.to.voluntariosColaborando.toUpperCase(),
                  style: AppTextTheme.textThemeColor(color: ColorsConfig.greyDark, fontSize: 18),
                ),
              ),
            ),
            Image.asset("assets/icons/ic_network.png", width: Responsive.to.oneUnitValueWidthScreen,),
          ],
        )*/
      ],
    );
  }

  Widget buildDonateTotal() {
    return Row(
      children: [
        SizedBox(
          width: Responsive.to.prefPaddinWidth,
        ),
        Text(
          Utils.formatarPreco(controller.app.reaisArrecadado),
          style: AppTextTheme.textThemeColorBold(color: ColorsConfig.greyDark, fontSize: 32),
        ),
        SizedBox(
          width: Responsive.to.prefPaddinWidth,
        ),
        Expanded(
          child: Center(
            child: Text(
              S.to.reaisArrecadados.toUpperCase(),
              style: AppTextTheme.textThemeColor(color: ColorsConfig.greyDark, fontSize: 18),
            ),
          ),
        ),
        Image.asset(
          "assets/icons/ic_coin.png",
          width: Responsive.to.oneUnitValueWidthScreen,
        ),
      ],
    );
  }

  Widget buildButtonDonate() {
    return SizedBox(
      width: Responsive.to.width,
      child: ElevatedButton(
        onPressed: () => Modular.to.pushNamed(RouterList.DONATE_PAYMENT_METHOD),
        child: Text(S.to.apoieEssaCausa),
      ),
    );
  }
}
