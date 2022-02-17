import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils.dart';
import 'package:utils/utils/constants/colors.dart';

import '../controllers/sign_in_user_password_store.dart';

class SignInUserPasswordPage extends StatefulWidget {
  @override
  _SignInUserPasswordPageState createState() => _SignInUserPasswordPageState();
}

class _SignInUserPasswordPageState extends ModularState<SignInUserPasswordPage, SignInUserPasswordStore> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          width: Responsive.to.widthWithoutPaddind,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  buildBackground(),
                  buildLogo(),
                  buildButtonBack(),
                ],
              ),
              SizedBox(height: Responsive.to.prefPaddinHeight),
              Text(
                S.to.login,
                style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryDarkColor, fontSize: 20),
              ),
              Form(
                key: controller.formKey,
                child: Padding(
                  padding: Responsive.to.prefPaddingSymmetric,
                  child: Column(
                    children: [
                      buildInputUser(),
                      SizedBox(
                        height: Responsive.to.prefPaddinHeight,
                      ),
                      buildInputPassword(),
                    ],
                  ),
                ),
              ),
              buildButtonSignin(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBackground() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Responsive.to.heightWithoutPaddind / 2),
            bottomRight: Radius.circular(Responsive.to.heightWithoutPaddind / 2)),
        image: DecorationImage(
          image: ExactAssetImage("assets/images/background.png"),
          fit: BoxFit.fitWidth,
        ),
      ),
      margin: EdgeInsets.only(bottom: Responsive.to.oneUnitValueWidthScreen),
      child: SizedBox(
        width: Responsive.to.widthWithoutPaddind,
        height: Responsive.to.oneUnitValueHeightScreen * 6,
      ),
    );
  }

  Widget buildLogo() {
    return Image.asset(
      "assets/logo.png",
      width: Responsive.to.oneUnitValueWidthScreen * 3,
      height: Responsive.to.oneUnitValueHeightScreen * 3,
    );
  }

  Widget buildButtonBack() {
    return Positioned(
      top: Responsive.to.oneUnitValueHeightScreen * 6 - Responsive.to.oneUnitValueWidthScreen * 1.2,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          primary: ColorsConfig.lightColor,
        ),
        child: SizedBox(
          height: Responsive.to.prefPaddinHeight * 4,
          width: Responsive.to.prefPaddinHeight * 4,
          child: Icon(
            FlutterIcons.clear_mdi,
            color: ColorsConfig.accentColor,
          ),
        ),
        onPressed: controller.back,
      ),
    );
  }

  Widget buildInputUser() {
    return TextFormField(
      autofocus: false,
      decoration: InputDecoration(
        hintText: S.to.usuario,
        fillColor: ColorsConfig.grey.withOpacity(0.5),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
          borderSide: BorderSide.none,
        ),
        contentPadding: Responsive.to.prefPaddingHorizontal,
      ),
      textAlign: TextAlign.center,
      onChanged: (value) => controller.email = value,
      validator: (value) => controller.v.validatorEmail(value!, S.to.emailInvalido),
    );
  }

  Widget buildInputPassword() {
    return TextFormField(
      autofocus: false,
      decoration: InputDecoration(
          hintText: S.to.senha,
          fillColor: ColorsConfig.grey.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.zero),
      obscureText: true,
      textAlign: TextAlign.center,
      onChanged: (value) => controller.password = value,
      validator: (value) => controller.v.validatorSenha(value!, S.to.senhaDeveTer6Caracteres),
    );
  }

  Widget buildButtonSignin() {
    return Padding(
      padding: Responsive.to.maxPaddingSymmetricOnlyHorizontal,
      child: ElevatedButton(
        onPressed: () => controller.signin(context),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(ColorsConfig.primaryColor),
          foregroundColor: MaterialStateProperty.all<Color>(ColorsConfig.lightColor),
        ),
        child: Container(
          width: Responsive.to.width,
          alignment: Alignment.center,
          child: Text(S.to.entrar),
        ),
      ),
    );
  }
}
