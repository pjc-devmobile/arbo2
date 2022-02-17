import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:utils/utils/constants/colors.dart';

import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/l10n/app_localization.dart';
import '../controllers/profile_store.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ModularState<ProfilePage, ProfileStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildInfoProfile(),
          SizedBox(
            height: Responsive.to.prefPaddinHeight,
          ),
          Padding(
            padding: Responsive.to.prefPaddingSymmetric,
            child: buildStatistic(),
          ),
          buildButtonLogoff(),
        ],
      ),
    );
  }

  Widget buildInfoProfile() {
    return Container(
      width: Responsive.to.width,
      decoration: BoxDecoration(
          color: ColorsConfig.primaryColor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36), bottomRight: Radius.circular(36))),
      child: Padding(
        padding: Responsive.to.prefPaddingSymmetric,
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: ColorsConfig.lightColor,
              child: Icon(
                Icons.person,
                color: ColorsConfig.primaryColor,
              ),
            ),
            SizedBox(
              height: Responsive.to.prefPaddinHeight / 2,
            ),
            Text(
              controller.currentUsuario.pessoa.nomeSobrenome,
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.lightColor, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  Widget buildStatistic() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
         S.to.estatistica,
          style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor, fontSize: 18),
        ),

        ///Árvores plantadass
        SizedBox(
          height: Responsive.to.prefPaddinHeight * 2,
        ),
        Row(
          children: [
            Image.asset(
              "assets/icons/ic_tree.png",
              width: Responsive.to.oneUnitValueWidthScreen,
            ),
            SizedBox(
              width: Responsive.to.prefPaddinWidth,
            ),
            Text(
              controller.currentUsuario.arvoresPlantadas.toString(),
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.greyDark, fontSize: 32),
            ),
            SizedBox(
              width: Responsive.to.prefPaddinWidth,
            ),
            Text(
             S.to.arvoresPlantadas.toUpperCase(),
              style: AppTextTheme.textThemeColor(color: ColorsConfig.greyDark, fontSize: 18),
            ),
          ],
        ),

        ///Árvores plantadass
        SizedBox(
          height: Responsive.to.prefPaddinHeight * 2,
        ),
        Row(
          children: [
            Image.asset(
              "assets/icons/ic_loaction.png",
              width: Responsive.to.oneUnitValueWidthScreen,
            ),
            SizedBox(
              width: Responsive.to.prefPaddinWidth,
            ),
            Text(
              controller.currentUsuario.arvoresMapeadas.toString(),
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.greyDark, fontSize: 32),
            ),
            SizedBox(
              width: Responsive.to.prefPaddinWidth,
            ),
            Text(
             S.to.arvoresMapeadas.toUpperCase(),
              style: AppTextTheme.textThemeColor(color: ColorsConfig.greyDark, fontSize: 18),
            ),
          ],
        ),

        ///Árvores plantadass
        SizedBox(
          height: Responsive.to.prefPaddinHeight * 2,
        ),
        Row(
          children: [
            Image.asset(
              "assets/icons/ic_user.png",
              width: Responsive.to.oneUnitValueWidthScreen,
            ),
            SizedBox(
              width: Responsive.to.prefPaddinWidth,
            ),
            Text(
              controller.currentUsuario.amigosConvidados.toString(),
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.greyDark, fontSize: 32),
            ),
            SizedBox(
              width: Responsive.to.prefPaddinWidth,
            ),
            Text(
             S.to.amigosConvidados.toUpperCase(),
              style: AppTextTheme.textThemeColor(color: ColorsConfig.greyDark, fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildButtonLogoff(){
    return Padding(
      padding: Responsive.to.prefPaddingSymmetric,
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(ColorsConfig.primaryColor),
        ),
        onPressed:()=> controller.logOff(context),
        child: Row(
          children: [
            Icon(Icons.exit_to_app),
            SizedBox(width: Responsive.to.prefPaddinWidth,),
            Text(S.to.sair),
          ],
        ),
      ),
    );
  }
}
