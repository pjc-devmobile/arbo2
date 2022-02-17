import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils/constants/colors.dart';
import 'package:utils/utils/text/app_text_theme.dart';

import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/l10n/app_localization.dart';
import '../controllers/sign_up_user_data_store.dart';

class SignUpUserDataPage extends StatefulWidget {
  @override
  _SignUpUserDataPageState createState() => _SignUpUserDataPageState();
}

class _SignUpUserDataPageState extends ModularState<SignUpUserDataPage, SignUpUserDataStore> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          width: Responsive.to.widthWithoutPaddind,
          child: Column(
            children: [
              buildImage(),
              buildButtonBack(),
              Form(
                key: controller.formKey,
                child: Padding(
                  padding: Responsive.to.prefPaddingSymmetric,
                  child: Column(
                    children: [
                      buildInputFullName(),
                      buildInputEmail(),
                      buildInputTelefone(),
                      buildInputCity(),
                      Row(
                        children: [
                          Expanded(child: buildInputPassword()),
                          SizedBox(
                            width: Responsive.to.prefPaddinWidth,
                          ),
                          Expanded(child: buildInputRepeatPassword()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Responsive.to.prefPaddinHeight,),
              buildCheckAcceptTerms(),
              SizedBox(height: Responsive.to.prefPaddinHeight/2,),
              buildButtonDone(),
              SizedBox(height: Responsive.to.prefPaddinHeight/2,),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    return Image.asset(
      "assets/images/folha_01.png",
      fit: BoxFit.fitWidth,
    );
  }

  Widget buildButtonBack() {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed:()=> Modular.to.pop(),
        ),
        Text(
          controller.appStore.firebaseUser == null ?S.to.criarConta :S.to.completeDados,
          style: AppTextTheme.textThemeColorBold(
            color: ColorsConfig.primaryDarkColor,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget buildInputFullName() {
    return TextFormField(
      initialValue: controller.fullName,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText:S.to.nomeCompleto,
      ),
      onChanged: (value) => controller.fullName = value,
      validator: (value) => controller.v.validatorNomeCompleto(value!,S.to.digiteNomeCompleto),
    );
  }

  Widget buildInputEmail() {
    return TextFormField(
      initialValue: controller.email,
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText:S.to.email,
      ),
      onChanged: (value) => controller.email = value,
      validator: (value) => controller.v.validatorEmail(value!,S.to.emailInvalido),
      enabled: controller.appStore.firebaseUser == null,
    );
  }

  Widget buildInputTelefone() {
    return TextFormField(
      controller: controller.controllerPhone,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(labelText:S.to.telefone, hintText: "(xx) 9 xxxx-xxxx"),
      onChanged: (value) => controller.phone = value,
      validator: (value) => controller.v.validatorCelular(value!,S.to.telefoneInvalido),
    );
  }

  Widget buildInputCity() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        TextFormField(
          controller: controller.controllerCity,
          decoration: InputDecoration(
            labelText:S.to.cidade,
            labelStyle: AppTextTheme.textThemeColor(fontSize: 16),
          ),
          validator: (value) => controller.v.validatorPadrao(value!,S.to.campoInvalido),
        ),
        InkWell(
          onTap: ()=> controller.chooseCity(context),
          child: Container(
            width: Responsive.to.widthWithoutPaddind,
            height: 75,
            color: ColorsConfig.primaryColor.withOpacity(0.0),
          ),
        ),
      ],
    );
  }

  Widget buildInputPassword() {
    return TextFormField(
      decoration: InputDecoration(
        labelText:S.to.senha,
      ),
      onChanged: (value) => controller.password = value,
      obscureText: true,
      validator: (value) => controller.v.validatorSenha(value!,S.to.senhaDeveTer6Caracteres),
    );
  }

  Widget buildInputRepeatPassword() {
    return TextFormField(
      decoration: InputDecoration(
        labelText:S.to.repitaSenha,
      ),
      obscureText: true,
      validator: (value) =>
          controller.v.validatorConfirmaSenha(value!, controller.password,S.to.senhasNaoConferem),
    );
  }

  Widget buildCheckAcceptTerms() {
    return Observer(builder: (_) {
      return Row(
        children: [
          SizedBox(width: Responsive.to.prefPaddinWidth,),
          InkWell(
            onTap: () => controller.setAcceptTerms(!controller.acceptTerms),
            child: Row(
              children: [
                Icon(controller.acceptTerms ? Icons.check_box : Icons.check_box_outline_blank, color: ColorsConfig.primaryColor,),
                SizedBox(width: Responsive.to.prefPaddinWidth/2,),
                Text(S.to.concordoCom, style: AppTextTheme.textThemeColor(fontSize: 12),),
              ],
            ),
          ),
          InkWell(
            onTap: () => controller.openTerms(),
            child: Text(
              " "+ S.to.termosUso,
              style: AppTextTheme.textThemeColor(fontSize: 12, color: ColorsConfig.primaryColor),
            ),
          ),
        ],
      );
    });
  }

  Widget buildButtonDone() {
    return Padding(
      padding: Responsive.to.maxPaddingSymmetricOnlyHorizontal,
      child: ElevatedButton(
        onPressed: ()=> controller.signup(context),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(ColorsConfig.primaryColor),
          foregroundColor: MaterialStateProperty.all<Color>(ColorsConfig.lightColor),
        ),
        child: Container(
          width: Responsive.to.width,
          alignment: Alignment.center,
          child: Text(S.to.confirmar),
        ),
      ),
    );
  }
}
