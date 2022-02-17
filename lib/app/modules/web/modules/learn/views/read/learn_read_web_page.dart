import 'package:arbo/app/modules/core/models/midia.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils.dart';
import 'package:utils/utils/constants/colors.dart';

import 'learn_read_web_store.dart';

class LearnReadWebPage extends StatefulWidget {
  @override
  _LearnReadWebPageState createState() => _LearnReadWebPageState();
}

class _LearnReadWebPageState extends ModularState<LearnReadWebPage, LearnReadWebStore> {
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
            buildMediasRead(),
            SizedBox(
              height: Responsive.to.prefPaddinHeight * 5,
            ),
          ],
        ),
      ),
      floatingActionButton: buildButtonNewMedia(),
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
            S.to.aprenda + " - " + S.to.paraLer,
            style: AppTextTheme.textThemeColorBold(color: ColorsConfig.lightColor, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget buildMediasRead() {
    return Observer(builder: (_) {
      if (controller.mediasRead == null)
        return Padding(
          padding: Responsive.to.maxPaddingSymmetricVertical,
          child: Center(child: LinearProgressIndicator()),
        );

      return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: Responsive.to.minPaddingSymmetric,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: Responsive.to.prefPaddinHeight * 25,
          crossAxisCount: Responsive.to.widthWithoutPaddind < 400 - 1
              ? 2
              : Responsive.to.widthWithoutPaddind < 400 * 3 - 1
                  ? 3
                  : Responsive.to.widthWithoutPaddind < 400 * 4 - 1
                      ? 4
                      : 5,
        ),
        itemCount: controller.mediasRead!.length,
        itemBuilder: (_, index) {
          return buildMediaItem(controller.mediasRead![index]);
        },
      );
    });
  }

  Widget buildMediaItem(Midia media) {
    //controller.getImageFromUrl(media.urlMin!);

    return Padding(
      padding: Responsive.to.minPaddingSymmetric,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(Responsive.to.minPaddingSymmetric),
          backgroundColor: MaterialStateProperty.all(ColorsConfig.backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        onPressed: () => Utils.launchURL(media.url),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Responsive.to.widthWithoutPaddind,
                height: Responsive.to.buttonExtraLargeHeight * 4,
                color: ColorsConfig.greyLight,
                child: CachedNetworkImage(
                  imageUrl: media.urlMin!,
                  height: Responsive.to.prefPaddinHeight * 25 * 0.75,
                ),
              ),
              SizedBox(
                height: Responsive.to.prefPaddinHeight,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      media.titulo,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextTheme.textThemeColor(),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              primary: ColorsConfig.redDarktColor,
                              padding: Responsive.to.minPaddingSymmetric,
                            ),
                            onPressed: () => controller.deleteMedia(media, context),
                            child: Text(S.to.excluir),
                          ),
                        ),
                        SizedBox(
                          width: Responsive.to.prefPaddinWidth / 2,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => controller.editMedia(media, context),
                            style: ElevatedButton.styleFrom(padding: Responsive.to.minPaddingSymmetric),
                            child: Text(S.to.editar),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtonNewMedia() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ColorsConfig.primaryDarkColor),
        elevation: MaterialStateProperty.all(5),
      ),
      onPressed: () => controller.newMedia(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add),
          SizedBox(
            width: Responsive.to.prefPaddinWidth,
          ),
          Text(S.to.novaMidia)
        ],
      ),
    );
  }
}
