import 'package:arbo/l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:utils/utils/constants/colors.dart';

import 'sign_in_user_password_web_store.dart';

class SignInUserPasswordWebPage extends StatefulWidget {
  @override
  _SignInUserPasswordWebPageState createState() => _SignInUserPasswordWebPageState();
}

class _SignInUserPasswordWebPageState
    extends ModularState<SignInUserPasswordWebPage, SignInUserPasswordWebStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage("assets/images/background.png"), repeat: ImageRepeat.repeatX),
        ),
        width: Responsive.to.widthWithoutPaddind,
        height: Responsive.to.height * 2,
        child: Center(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: Responsive.to.prefPaddinHeight,
                ),
                Container(
                  width: Responsive.to.oneUnitValueWidthScreen * 4,
                  padding: Responsive.to.prefPaddingSymmetric,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        color: ColorsConfig.primaryColor,
                        height: Responsive.to.oneUnitValueHeightScreen,
                      ),
                      SizedBox(
                        height: Responsive.to.prefPaddinHeight,
                      ),
                      Form(
                        key: controller.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            buildInputUser(),
                            SizedBox(
                              height: Responsive.to.prefPaddinHeight,
                            ),
                            buildInputPassword(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Responsive.to.prefPaddinHeight * 2,
                      ),
                      SizedBox(
                        width: Responsive.to.oneUnitValueWidthScreen * 2.5,
                        child: buildButtonSignin(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Responsive.to.prefPaddinHeight,
                ),
                buildContactDeveloper(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputUser() {
    return TextFormField(
      autofocus: false,
      decoration: InputDecoration(
        hintText:S.to.usuario,
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
      validator: (value) => controller.v.validatorEmail(value!,S.to.emailInvalido),
    );
  }

  Widget buildInputPassword() {
    return TextFormField(
      autofocus: false,
      decoration: InputDecoration(
          hintText:S.to.senha,
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
      validator: (value) => controller.v.validatorSenha(value!,S.to.senhaDeveTer6Caracteres),
    );
  }

  Widget buildButtonSignin() {
    return ElevatedButton(
      onPressed: () => controller.signin(context),
      child: Container(
        width: Responsive.to.widthWithoutPaddind,
        alignment: Alignment.center,
        child: Text(S.to.entrar),
      ),
    );
  }

  Widget buildContactDeveloper() {
    return Container(
      width: Responsive.to.oneUnitValueWidthScreen * 4,
      color: ColorsConfig.grey.withOpacity(0.1),
      alignment: Alignment.centerRight,
      padding: Responsive.to.minPaddingSymmetric,
      child: TextButton(
        onPressed: () =>
            Utils.launchURL("https://api.whatsapp.com/send?phone=5577981201820&text=Ol%C3%A1%2C%20Pedro!"),
        child: Text(
          "Contate o desenvolvedor",
          style: AppTextTheme.textThemeColor(color: ColorsConfig.grey),
        ),
      ),
    );
  }
}
