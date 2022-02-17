import 'package:arbo/app/modules/core/models/midia.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:utils/utils/constants/colors.dart';

import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/l10n/app_localization.dart';
import '../controllers/learn_store.dart';

class LearnPage extends StatefulWidget {
  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends ModularState<LearnPage, LearnStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildHead(),
            SizedBox(
              height: Responsive.to.prefPaddinHeight*2,
            ),
            buildMediasWatch(),
            SizedBox(
              height: Responsive.to.prefPaddinHeight*2,
            ),
            buildMediasRead(),
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
             S.to.aprenda,
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
                  Icons.menu_book,
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

  Widget buildMediasWatch(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: Responsive.to.prefPaddingHorizontal,
          child: Text(S.to.paraAssistir, style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor, fontSize: 18),),
        ),

        ///Lista de midias
        Observer(builder: (_) {
          if (controller.mediasWatch == null)
            return Padding(padding: Responsive.to.maxPaddingSymmetricVertical,
              child: Center(child: LinearProgressIndicator()),
            );

          return Container(
            padding: Responsive.to.prefPaddingSymmetric,
            width: Responsive.to.widthWithoutPaddind,
            height: Responsive.to.oneUnitValueHeightScreen*2.5,
            child: ListView.builder(
              itemCount: controller.mediasWatch!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return buildMediaItem(controller.mediasWatch![index]);
              },
            ),
          );
        }),
      ],
    );
  }

  Widget buildMediasRead(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: Responsive.to.prefPaddingHorizontal,
          child: Text(S.to.paraLer, style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor, fontSize: 18),),
        ),

        ///Lista de midias
        Observer(builder: (_) {
          if (controller.mediasRead == null)
            return Padding(padding: Responsive.to.maxPaddingSymmetricVertical,
              child: Center(child: LinearProgressIndicator()),
            );

          return Container(
            padding: Responsive.to.prefPaddingSymmetric,
            width: Responsive.to.widthWithoutPaddind,
            height: Responsive.to.oneUnitValueHeightScreen*2.5,
            child: ListView.builder(
              itemCount: controller.mediasRead!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return buildMediaItem(controller.mediasRead![index]);
              },
            ),
          );
        }),
      ],
    );
  }

  Widget buildMediaItem(Midia midia){
    String urlPreviewVideo = "";
    if(midia.tipo == TipoMidia.LINK_YOUTUBE) {
      final Uri uri = Uri.tryParse(midia.url)!;
      urlPreviewVideo = 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
    }

    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(Responsive.to.prefPaddingHorizontal)
      ),
      onPressed: ()=> Utils.launchURL(midia.url),
      child: Container(
        width: Responsive.to.oneUnitValueWidthScreen * 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (midia.tipo == TipoMidia.LINK_YOUTUBE)
              Container(
                width: Responsive.to.widthWithoutPaddind,
                height: Responsive.to.oneUnitValueWidthScreen * 2.5,
                color: ColorsConfig.greyLight,
                child: CachedNetworkImage(
                  imageUrl: urlPreviewVideo,
                ),
              ),
            if (midia.tipo == TipoMidia.LINK_SITE)
              Container(
                width: Responsive.to.widthWithoutPaddind,
                height: Responsive.to.oneUnitValueWidthScreen * 2.5,
                color: ColorsConfig.greyLight,
                child: CachedNetworkImage(
                  imageUrl: midia.urlMin!,
                ),
              ),
            SizedBox(
              height: Responsive.to.prefPaddinHeight/2,
            ),
            Expanded(
              child: Text(
                midia.titulo,
                overflow: TextOverflow.ellipsis,
                style: AppTextTheme.textThemeColor(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
