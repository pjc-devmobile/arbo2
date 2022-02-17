import 'package:arbo/app/modules/core/models/estado_ativo.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:utils/utils/constants/colors.dart';

import 'states_actives_web_store.dart';

class StatesActivesWebPage extends StatefulWidget {
  @override
  _StatesActivesWebPageState createState() => _StatesActivesWebPageState();
}

class _StatesActivesWebPageState extends ModularState<StatesActivesWebPage, StatesActivesWebStore> {
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
            buildStates(),
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
          child: Text(
           S.to.estadosAtivos,
            style: AppTextTheme.textThemeColorBold(color: ColorsConfig.lightColor, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget buildStates() {
    return Observer(builder: (_) {
      if (controller.states == null)
        return Padding(
          padding: Responsive.to.maxPaddingSymmetricVertical,
          child: Center(child: LinearProgressIndicator()),
        );

      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: Responsive.to.minPaddingSymmetric,
        itemCount: controller.states!.length,
        itemBuilder: (_, index) {
          return buildStateItem(controller.states![index]);
        },
      );
    });
  }

  ///Widgets ITEM ESTADO

  Widget buildStateItem(EstadoAtivo state) {
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
        onPressed: () => controller.detailsState(state),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.estado,
                  style: AppTextTheme.textThemeColorBold(
                    color: ColorsConfig.primaryDarkColor,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: Responsive.to.prefPaddinHeight/1.5,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: buildInfoStateLeft(state)),
                    Expanded(child: buildInfoStateRight(state)),
                  ],
                ),
              ],
            ),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }

  Widget buildInfoStateLeft(EstadoAtivo state){
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
        SizedBox(height: Responsive.to.prefPaddinHeight/4,),
        Text.rich(
          TextSpan(
              text:S.to.arvoresProduzindo,
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor, fontSize: 16),
              children: [
                TextSpan(
                  text: ": ${state.arvoresProduzindo}",
                  style: AppTextTheme.textThemeColor(fontSize: 16),
                )
              ]),
        ),
      ],
    );
  }

  Widget buildInfoStateRight(EstadoAtivo state){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
              text:S.to.cidadesAtivas,
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor, fontSize: 16),
              children: [
                TextSpan(
                  text: ": ${state.cidadesAtivas}",
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
                  text: ": ${state.usuariosCadastrados}",
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
                  text: ": ${state.voluntariosColaborando}",
                  style: AppTextTheme.textThemeColor(fontSize: 16),
                )
              ]),
        ),
      ],
    );
  }
}
