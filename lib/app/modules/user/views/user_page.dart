import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:utils/utils/constants/colors.dart';

import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/l10n/app_localization.dart';
import '../controllers/user_store.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends ModularState<UserPage, UserStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive.to.isPortrair ? buildPortrair() : buildLand(),
    );
  }

  Widget buildPortrair(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Botão voltar e perfil
        buildButtonBackInfoProfile(),

        ///Padding
        Padding(
          padding: Responsive.to.prefPaddingSymmetric,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Responsive.to.prefPaddinHeight,),
              buildStatistic(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildLand(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Botão voltar e perfil
        Expanded(child: buildButtonBackInfoProfile()),

        ///Padding
        Expanded(
          child: Padding(
            padding: Responsive.to.prefPaddingSymmetric,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Responsive.to.prefPaddinHeight,),
                buildStatistic(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButtonBackInfoProfile(){
    return Container(
      width: Responsive.to.width,
      decoration: BoxDecoration(
        color: ColorsConfig.primaryColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36), bottomRight: Radius.circular(36))
      ),
      child: SafeArea(
        child: Padding(
          padding: Responsive.to.prefPaddingSymmetric,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(0, 0)),
                  ),
                  child: Icon(Icons.arrow_back),
                  onPressed: ()=> Modular.to.pop(),
                ),
              ),
              CircleAvatar(
                backgroundColor: ColorsConfig.lightColor,
                radius: Responsive.to.oneUnitValueWidthScreen,
                child: Icon(
                  Icons.person,
                  color: ColorsConfig.primaryColor,
                ),
              ),
              SizedBox(height: Responsive.to.prefPaddinHeight/2,),
              Text(
                controller.infoUser.nome,
                style: AppTextTheme.textThemeColorBold(
                  color: ColorsConfig.lightColor,
                  fontSize: 20
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStatistic(){
    return Observer(builder: (_){
      if(controller.user == null)
        return Center(
          child: Padding(
            padding: Responsive.to.maxPaddingSymmetricVertical,
            child: CircularProgressIndicator(),
          ),
        );

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
           S.to.estatistica,
            style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor, fontSize: 18),
          ),
          ///Árvores plantadass
          SizedBox(height: Responsive.to.prefPaddinHeight*2,),
          Row(
            children: [
              Image.asset("assets/icons/ic_tree.png", width: Responsive.to.oneUnitValueWidthScreen,),
              SizedBox(width: Responsive.to.prefPaddinWidth,),
              Text(
                controller.user!.arvoresPlantadas.toString(),
                style: AppTextTheme.textThemeColorBold(color: ColorsConfig.greyDark, fontSize: 32),
              ),
              SizedBox(width: Responsive.to.prefPaddinWidth,),
              Text(
               S.to.arvoresPlantadas.toUpperCase(),
                style: AppTextTheme.textThemeColor(color: ColorsConfig.greyDark, fontSize: 18),
              ),
            ],
          ),
          ///Árvores plantadass
          SizedBox(height: Responsive.to.prefPaddinHeight*2,),
          Row(
            children: [
              Image.asset("assets/icons/ic_loaction.png", width: Responsive.to.oneUnitValueWidthScreen,),
              SizedBox(width: Responsive.to.prefPaddinWidth,),
              Text(
                controller.user!.arvoresMapeadas.toString(),
                style: AppTextTheme.textThemeColorBold(color: ColorsConfig.greyDark, fontSize: 32),
              ),
              SizedBox(width: Responsive.to.prefPaddinWidth,),
              Text(
               S.to.arvoresMapeadas.toUpperCase(),
                style: AppTextTheme.textThemeColor(color: ColorsConfig.greyDark, fontSize: 18),
              ),
            ],
          ),
          ///Árvores plantadass
          SizedBox(height: Responsive.to.prefPaddinHeight*2,),
          Row(
            children: [
              Image.asset("assets/icons/ic_user.png", width: Responsive.to.oneUnitValueWidthScreen,),
              SizedBox(width: Responsive.to.prefPaddinWidth,),
              Text(
                controller.user!.amigosConvidados.toString(),
                style: AppTextTheme.textThemeColorBold(color: ColorsConfig.greyDark, fontSize: 32),
              ),
              SizedBox(width: Responsive.to.prefPaddinWidth,),
              Text(
               S.to.amigosConvidados.toUpperCase(),
                style: AppTextTheme.textThemeColor(color: ColorsConfig.greyDark, fontSize: 18),
              ),
            ],
          ),
        ],
      );
    });
  }
}
