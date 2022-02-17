import 'package:arbo/app/modules/core/models/arvore.dart';
import 'package:arbo/app/modules/core/models/meses_util.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils.dart';
import 'package:utils/utils/constants/colors.dart';

import 'trees_pending_web_store.dart';

class TreesPendingWebPage extends StatefulWidget {
  @override
  _TreesPendingWebPageState createState() => _TreesPendingWebPageState();
}

class _TreesPendingWebPageState extends ModularState<TreesPendingWebPage, TreesPendingWebStore> {
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
            buildTrees(),
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
            S.to.arvoresPendentes,
            style: AppTextTheme.textThemeColorBold(color: ColorsConfig.lightColor, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget buildTrees() {
    return Observer(builder: (_) {
      if (controller.trees == null)
        return Padding(
          padding: Responsive.to.maxPaddingSymmetricVertical,
          child: Center(child: LinearProgressIndicator()),
        );

      return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: Responsive.to.minPaddingSymmetric,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3 / 5,
          //mainAxisExtent: Responsive.to.prefPaddinHeight * 25,
          crossAxisCount: Responsive.to.widthWithoutPaddind < 400 * 3 - 1
              ? 2
              : Responsive.to.widthWithoutPaddind < 400 * 4 - 1
                  ? 3
                  : 4,
        ),
        itemCount: controller.trees!.length,
        itemBuilder: (_, index) {
          return buildTreeItem(controller.trees![index]);
        },
      );
    });
  }

  ///Widgets ITEM ARVORE

  Widget buildTreeItem(Arvore tree) {
    return Padding(
      padding: Responsive.to.minPaddingSymmetric,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(Responsive.to.minPaddingSymmetric),
          backgroundColor: MaterialStateProperty.all(ColorsConfig.backgroundColor),
          foregroundColor: MaterialStateProperty.all(ColorsConfig.primaryDarkColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        onPressed: () => controller.detailsTree(tree),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Text(
                    tree.nome,
                    style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor, fontSize: 18),
                  ),
                  SizedBox(
                    height: Responsive.to.prefPaddinHeight / 2,
                  ),
                  buildImage(tree),
                  SizedBox(
                    height: Responsive.to.prefPaddinHeight / 2,
                  ),
                  buildInfoUser(tree),
                  Divider(),
                  buildDescription(tree),
                  Divider(),
                  buildProducing(tree),
                  Divider(),
                  buildLocation(tree),
                  SizedBox(
                    height: Responsive.to.prefPaddinHeight * 2,
                  ),
                  buildMonthsProducing(tree),
                ],
              ),
            ),
            buildButtons(tree),
          ],
        ),
      ),
    );
  }

  Widget buildImage(Arvore tree) {
    return Container(
      color: ColorsConfig.grey.withOpacity(0.3),
      width: Responsive.to.widthWithoutPaddind,
      height: Responsive.to.oneUnitValueHeightScreen * 2,
      child: CachedNetworkImage(
        imageUrl: tree.imagem.url,
        placeholder: (context, url) => Container(
          height: Responsive.to.oneUnitValueHeightScreen * 3,
          child: Center(child: LinearProgressIndicator()),
        ),
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget buildDescription(Arvore tree) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.to.descricao,
          style: AppTextTheme.textThemeColor(color: ColorsConfig.primaryColor),
        ),
        Text(
          tree.descricao,
          style: AppTextTheme.textThemeColor(),
        ),
      ],
    );
  }

  Widget buildProducing(Arvore tree) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.to.arvoreJaProduz,
          style: AppTextTheme.textThemeColor(color: ColorsConfig.primaryColor),
        ),
        Text(
          tree.produzindo ? S.to.sim : S.to.nao,
          style: AppTextTheme.textThemeColor(),
        ),
      ],
    );
  }

  Widget buildLocation(Arvore tree) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: Responsive.to.oneUnitValueHeightScreen / 2,
        ),
        SizedBox(
          width: Responsive.to.prefPaddinWidth / 2,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (tree.endereco.endereco != null)
                Text(
                  tree.endereco.endereco!,
                  style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor),
                ),
              Text(
                tree.endereco.cidadeNome,
                style: AppTextTheme.textThemeColor(color: ColorsConfig.primaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildInfoUser(Arvore tree) {
    return Row(
      children: [
        CircleAvatar(
          radius: Responsive.to.oneUnitValueWidthScreen * .2,
          child: Icon(
            Icons.person,
            size: Responsive.to.oneUnitValueWidthScreen * .2,
          ),
        ),
        SizedBox(
          width: Responsive.to.prefPaddinWidth / 2,
        ),
        Expanded(
            child: Text(
          tree.infoUsuario.nome,
          style: AppTextTheme.textTheme(),
        )),
      ],
    );
  }

  Widget buildMonthsProducing(Arvore tree) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.to.mesesDeProducao,
          style: AppTextTheme.textThemeColor(color: Colors.black87),
        ),

        ///Inicio e fim
        Row(
          children: [
            if(tree.mesesProducao.isNotEmpty)
              OutlinedButton(
              onPressed: null,
              child: Text(MesesUtil.MONTHS_NAME[tree.mesesProducao[0]]),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(Responsive.to.minPaddingSymmetric),
                  minimumSize: MaterialStateProperty.all(Size(0, 0))),
            ),
            Expanded(
              child: Container(
                margin: Responsive.to.minPaddingSymmetric,
                color: ColorsConfig.primaryColor,
                height: 1,
              ),
            ),
            if(tree.mesesProducao.length > 1)
              OutlinedButton(
              onPressed: null,
              child: Text(MesesUtil.MONTHS_NAME[tree.mesesProducao[1]]),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(Responsive.to.minPaddingSymmetric),
                  minimumSize: MaterialStateProperty.all(Size(0, 0))),
            ),
          ],
        ),
      ],
    );
  }

  ///Aprovar e reprovar
  Widget buildButtons(Arvore tree) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(ColorsConfig.grey.withOpacity(0.3)),
            ),
            onPressed: () => controller.decline(tree, context),
            child: Text(S.to.reprovar),
          ),
        ),
        SizedBox(
          width: Responsive.to.prefPaddinWidth,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () => controller.approve(tree, context),
            child: Text(S.to.aprovar),
          ),
        )
      ],
    );
  }
}
