import 'package:arbo/app/modules/sign/controllers/sign_type_store.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils.dart';
import 'package:utils/utils/constants/colors.dart';

class SignTypePage extends StatefulWidget {
  @override
  _SignTypePageState createState() => _SignTypePageState();
}

class _SignTypePageState extends ModularState<SignTypePage, SignTypeStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      body: Container(
        height: Responsive.to.heightWithoutPaddind,
        width: Responsive.to.widthWithoutPaddind,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/images/background.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child: Image.asset(
                "assets/logo.png",
                width: Responsive.to.oneUnitValueWidthScreen * 3,
                height: Responsive.to.oneUnitValueHeightScreen * 3,
              ),
            ),
            Spacer(),
            buildButtonLogin(),
            buildOr(),
            buildButtonsSotials(),
            buildButtonSignup(),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget buildButtonLogin() {
    return Padding(
      padding: Responsive.to.maxPaddingSymmetricOnlyHorizontal,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ColorsConfig.lightColor),
          foregroundColor: MaterialStateProperty.all(ColorsConfig.primaryColor),
        ),
        child: Container(
          alignment: Alignment.center,
          width: Responsive.to.width,
          child: Text(S.to.login),
        ),
        onPressed: controller.login,
      ),
    );
  }

  Widget buildOr() {
    return Padding(
      padding: Responsive.to.prefPaddingSymmetric,
      child: Text(
        S.to.ou,
        style: AppTextTheme.textThemeColorBold(color: ColorsConfig.lightColor, fontSize: 16),
      ),
    );
  }

  Widget buildButtonsSotials() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            primary: ColorsConfig.lightColor,
            padding: Responsive.to.minPaddingSymmetric,
          ),
          child: SizedBox(
            height: Responsive.to.prefPaddinHeight * 4,
            width: Responsive.to.prefPaddinHeight * 4,
            child: Icon(
              FlutterIcons.facebook_f_faw,
              color: ColorsConfig.primaryColor,
            ),
          ),
          onPressed: () => controller.signInFacebook(context),
        ),
        SizedBox(
          width: Responsive.to.prefPaddinWidth * 2,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            primary: ColorsConfig.lightColor,
            padding: Responsive.to.minPaddingSymmetric,
          ),
          child: SizedBox(
            height: Responsive.to.prefPaddinHeight * 4,
            width: Responsive.to.prefPaddinHeight * 4,
            child: Icon(
              FlutterIcons.google_plus_faw,
              color: ColorsConfig.primaryColor,
            ),
          ),
          onPressed: () => controller.signInGoogle(context),
        ),
      ],
    );
  }

  Widget buildButtonSignup() {
    return TextButton(
      onPressed: controller.signUp,
      style: ButtonStyle(),
      child: Text(S.to.casoNaoPossuaContaCadastre),
    );
  }
}
