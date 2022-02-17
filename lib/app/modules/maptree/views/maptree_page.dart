import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:utils/utils.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:utils/utils/constants/colors.dart';

import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/l10n/app_localization.dart';
import '../controllers/maptree_store.dart';

class MapTreePage extends StatefulWidget {
  @override
  _MapTreePageState createState() => _MapTreePageState();
}

class _MapTreePageState extends ModularState<MapTreePage, MapTreeStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHead(),
            SizedBox(
              height: Responsive.to.prefPaddinHeight,
            ),
            Padding(
              padding: Responsive.to.prefPaddingSymmetric,
              child: Column(
                children: [
                  buildMapLocal(),
                  SizedBox(
                    height: Responsive.to.prefPaddinHeight * 2,
                  ),
                  buildImage(),
                  SizedBox(
                    height: Responsive.to.prefPaddinHeight * 2,
                  ),
                  buildNameTree(),
                  SizedBox(
                    height: Responsive.to.prefPaddinHeight,
                  ),
                  buildDescriptionLocal(),
                  SizedBox(
                    height: Responsive.to.prefPaddinHeight * 2,
                  ),
                  buildTreeProducing(),
                  SizedBox(
                    height: Responsive.to.prefPaddinHeight * 2,
                  ),
                  buildMonthsProducing(),
                  SizedBox(
                    height: Responsive.to.prefPaddinHeight,
                  ),
                  buildButtonDone(),
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
          children: [
            buildButtonMenu(),
            Center(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/arvore.png",
                    height: Responsive.to.oneUnitValueHeightScreen * 1.5,
                  ),
                  SizedBox(
                    height: Responsive.to.prefPaddinHeight / 2,
                  ),
                  Text(
                    S.to.mapearArovore,
                    style: AppTextTheme.textThemeColorBold(color: ColorsConfig.lightColor, fontSize: 20),
                  )
                ],
              ),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: ColorsConfig.lightColor,
              child: Icon(
                Icons.add_location_alt_sharp,
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
        onPressed: controller.toggleShowingTabBar,
      );
    });
  }

  Widget buildMapLocal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
              text: S.to.local,
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor, fontSize: 16),
              children: [
                TextSpan(
                  text: " *",
                  style: AppTextTheme.textThemeColor(color: Colors.red, fontSize: 16),
                )
              ]),
        ),
        SizedBox(
          height: Responsive.to.prefPaddinHeight,
        ),
        Observer(
          builder: (_) {
            return controller.markers == null
                ? Center(child: CircularProgressIndicator())
                : Container(
                    width: Responsive.to.width,
                    height: Responsive.to.oneUnitValueHeightScreen * 2.5,
                    child: GoogleMap(
                      zoomControlsEnabled: false,
                      mapType: MapType.normal,
                      initialCameraPosition: controller.cameraPosition,
                      onMapCreated: (GoogleMapController gmController) {
                        controller.controllerMap.complete(gmController);
                      },
                      markers: controller.markers!,
                    ),
                  );
          },
        ),
        SizedBox(
          height: Responsive.to.prefPaddinHeight / 2,
        ),
        Text(S.to.arvoreMapeadaLocalAtual),
      ],
    );
  }

  Widget buildImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: S.to.imagem,
            style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor, fontSize: 16),
            children: [
              TextSpan(
                text: " *",
                style: AppTextTheme.textThemeColor(color: Colors.red, fontSize: 16),
              )
            ],
          ),
        ),
        SizedBox(
          height: Responsive.to.prefPaddinHeight,
        ),
        Observer(
          builder: (_) {
            return controller.imageFile == null
                ? Container(
                    color: ColorsConfig.grey.withOpacity(0.3),
                    width: Responsive.to.width,
                    height: Responsive.to.oneUnitValueHeightScreen * 2.5,
                    child: IconButton(
                      onPressed: controller.chooseImage,
                      icon: Icon(
                        Icons.image,
                        color: ColorsConfig.primaryColor,
                        size: Responsive.to.oneUnitValueHeightScreen * .75,
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: controller.chooseImage,
                    child: Container(
                      width: Responsive.to.width,
                      height: Responsive.to.oneUnitValueHeightScreen * 2.5,
                      color: ColorsConfig.grey.withOpacity(0.3),
                      child: Image.file(
                        controller.imageFile!,
                        width: Responsive.to.width,
                        height: Responsive.to.oneUnitValueHeightScreen * 2.5,
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }

  Widget buildNameTree() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
              text: S.to.nomeArvore,
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor, fontSize: 16),
              children: [
                TextSpan(
                  text: " *",
                  style: AppTextTheme.textThemeColor(color: Colors.red, fontSize: 16),
                )
              ]),
        ),
        TextFormField(
          textCapitalization: TextCapitalization.words,
          onChanged: (value) => controller.setProperty(name: value),
          decoration: InputDecoration(
            hintText: S.to.macieriaLarangeiraBananeira,
          ),
        ),
      ],
    );
  }

  Widget buildDescriptionLocal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
              text: S.to.descricaoLocal,
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor, fontSize: 16),
              children: [
                TextSpan(
                  text: " *",
                  style: AppTextTheme.textThemeColor(color: Colors.red, fontSize: 16),
                )
              ]),
        ),
        TextFormField(
          textCapitalization: TextCapitalization.words,
          onChanged: (value) => controller.setProperty(description: value),
          decoration: InputDecoration(
            hintText: S.to.subindoLadeiraDoParque,
          ),
        ),
      ],
    );
  }

  Widget buildTreeProducing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
              text: S.to.arvoreJaProduz,
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor, fontSize: 16),
              children: [
                TextSpan(
                  text: " *",
                  style: AppTextTheme.textThemeColor(color: Colors.red, fontSize: 16),
                )
              ]),
        ),
        Row(
          children: [
            ///Sim
            Observer(
              builder: (_) {
                return TextButton(
                  onPressed: () => controller.setProperty(producing: true),
                  child: Row(
                    children: [
                      Icon(
                        controller.producing ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                        color: ColorsConfig.primaryColor,
                      ),
                      SizedBox(
                        width: Responsive.to.prefPaddinWidth / 2,
                      ),
                      Text(
                        S.to.sim,
                        style: AppTextTheme.textThemeColor(color: ColorsConfig.primaryColor),
                      ),
                    ],
                  ),
                );
              },
            ),

            ///Não
            Observer(
              builder: (_) {
                return TextButton(
                  onPressed: () => controller.setProperty(producing: false),
                  child: Row(
                    children: [
                      Icon(
                        controller.producing ? Icons.radio_button_unchecked : Icons.radio_button_checked,
                        color: ColorsConfig.primaryColor,
                      ),
                      SizedBox(
                        width: Responsive.to.prefPaddinWidth / 2,
                      ),
                      Text(
                        S.to.nao,
                        style: AppTextTheme.textThemeColor(color: ColorsConfig.primaryColor),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildMonthsProducing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.to.informacoesAdicionais,
          style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor, fontSize: 16),
        ),
        Text(
          S.to.mesesDeProducao,
          style: AppTextTheme.textThemeColor(),
        ),

        ///Inicio e fim
        Row(
          children: [
            Expanded(
              child: Observer(
                builder: (_) {
                  return OutlinedButton(
                    onPressed: () => controller.pickerMonthStart(context),
                    child: Text(controller.monthStartName == null ? S.to.inicio : controller.monthStartName!),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(Responsive.to.minPaddingSymmetric),
                        minimumSize: MaterialStateProperty.all(Size(0, 0))),
                  );
                },
              ),
            ),
            Container(
              margin: Responsive.to.prefPaddingSymmetric,
              color: ColorsConfig.primaryColor,
              width: Responsive.to.prefPaddinWidth * 6,
              height: 1,
            ),
            Expanded(
              child: Observer(
                builder: (_) {
                  return OutlinedButton(
                    onPressed: () => controller.pickerMonthEnd(context),
                    child: Text(controller.monthEndName == null ? S.to.fim : controller.monthEndName!),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(Responsive.to.minPaddingSymmetric),
                        minimumSize: MaterialStateProperty.all(Size(0, 0))),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildButtonDone() {
    return Observer(
      builder: (_) {
        return ElevatedButton(
          onPressed: controller.fieldsFill ? () => controller.save(context) : null,
          child: Text(S.to.concluir),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(
                horizontal: Responsive.to.prefPaddinWidth * 3,
              ),
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) return ColorsConfig.grey.withOpacity(0.3);
                return ColorsConfig.primaryColor; // Use the component's default.
              },
            ),
            /*foregroundColor: MaterialStateProperty.all(ColorsConfig.lightColor),*/
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      },
    );
  }
}
