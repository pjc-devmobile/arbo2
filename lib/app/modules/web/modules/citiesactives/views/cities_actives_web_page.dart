import 'package:arbo/app/modules/core/models/cidade_ativa.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:utils/utils/constants/colors.dart';

import 'cities_actives_web_store.dart';

class CitiesActivesWebPage extends StatefulWidget {
  @override
  _CitiesActivesWebPageState createState() => _CitiesActivesWebPageState();
}

class _CitiesActivesWebPageState extends ModularState<CitiesActivesWebPage, CitiesActivesWebStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildHead(),
            SizedBox(
              height: Responsive.to.prefPaddinHeight * 2,
            ),
            buildCities(),
            SizedBox(
              height: Responsive.to.prefPaddinHeight * 5,
            ),
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
        padding: EdgeInsets.symmetric(
          vertical: Responsive.to.prefPaddinHeight * 1.5,
          horizontal: Responsive.to.prefPaddinWidth * 2,
        ),
        child: SafeArea(
          child: Row(
            children: [
              IconButton(
                onPressed: ()=> controller.back(),
                icon: Icon(Icons.arrow_back, color: ColorsConfig.lightColor,),
              ),
              Text(
                controller.state.estado,
                style: AppTextTheme.textThemeColorBold(color: ColorsConfig.lightColor, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCities() {
    return Observer(builder: (_) {
      if (controller.cities == null)
        return Padding(
          padding: Responsive.to.maxPaddingSymmetricVertical,
          child: Center(child: LinearProgressIndicator()),
        );

      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: Responsive.to.minPaddingSymmetric,
        itemCount: controller.cities!.length,
        itemBuilder: (_, index) {
          return buildCityItem(controller.cities![index]);
        },
      );
    });
  }

  ///Widgets ITEM CIDADE

  Widget buildCityItem(CidadeAtiva state) {
    return Padding(
      padding: Responsive.to.prefPaddingSymmetric,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(Responsive.to.prefPaddingSymmetric),
          backgroundColor: MaterialStateProperty.all(ColorsConfig.backgroundColor),
          foregroundColor: MaterialStateProperty.all(ColorsConfig.primaryDarkColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        onPressed: () => {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.cidade,
              style: AppTextTheme.textThemeColorBold(
                color: ColorsConfig.primaryDarkColor,
                fontSize: 18,
              ),
            ),
            SizedBox(height: Responsive.to.prefPaddinHeight/1.5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: buildInfoCityLeft(state)),
                Expanded(child: buildInfoCityRight(state)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoCityLeft(CidadeAtiva state){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
              text:S.to.arvoresMapeadas,
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor, fontSize: 16),
              children: [
                TextSpan(
                  text: ": ${state.arvoresMapeadas}",
                  style: AppTextTheme.textThemeColor(fontSize: 16),
                )
              ]),
        ),
        SizedBox(height: Responsive.to.prefPaddinHeight/4,),
        Text.rich(
          TextSpan(
              text:S.to.arvoresPlantadas,
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor, fontSize: 16),
              children: [
                TextSpan(
                  text: ": ${state.arvoresPlantadas}",
                  style: AppTextTheme.textThemeColor(fontSize: 16),
                )
              ]),
        ),
      ],
    );
  }

  Widget buildInfoCityRight(CidadeAtiva city){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
              text:S.to.arvoresProduzindo,
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor, fontSize: 16),
              children: [
                TextSpan(
                  text: ": ${city.arvoresProduzindo}",
                  style: AppTextTheme.textThemeColor(fontSize: 16),
                )
              ]),
        ),
        SizedBox(height: Responsive.to.prefPaddinHeight/4,),
        Text.rich(
          TextSpan(
              text:S.to.usuariosCadastrados,
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor, fontSize: 16),
              children: [
                TextSpan(
                  text: ": ${city.usuariosCadastrados}",
                  style: AppTextTheme.textThemeColor(fontSize: 16),
                )
              ]),
        ),
        SizedBox(height: Responsive.to.prefPaddinHeight/4,),
        Text.rich(
          TextSpan(
              text:S.to.voluntariosColaborando,
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor, fontSize: 16),
              children: [
                TextSpan(
                  text: ": ${city.voluntariosColaborando}",
                  style: AppTextTheme.textThemeColor(fontSize: 16),
                )
              ]),
        ),
      ],
    );
  }
}
