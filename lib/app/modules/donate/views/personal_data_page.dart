import 'package:arbo/app/modules/donate/controllers/personal_data_store.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils.dart';
import 'package:utils/utils/constants/colors.dart';
import 'package:utils/utils/text/app_text_theme.dart';

class PersonalDataPage extends StatefulWidget {
  @override
  _PersonalDataPageState createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends ModularState<PersonalDataPage, PersonalDataStore> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildHead(),
          Expanded(
            child: buildForm(),
          ),
          Padding(
            padding: Responsive.to.prefPaddingSymmetric,
            child: buildButtonConfirm(),
          ),
        ],
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
        child: Row(
          children: [
            TextButton(
              child: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                shape: CircleBorder(),
              ),
            ),
            Text(
              S.to.dadosPessoais,
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.lightColor, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildForm(){
    return Form(
      key: controller.formKey,
      child: ListView(
        padding: Responsive.to.prefPaddingSymmetric,
        children: [
          Text(S.to.confirmeDadosPessoais, style: AppTextTheme.textThemeBold(fontSize: 18),),
          buildInputName(),
          buildInputEmail(),
          buildInputCpfCnpj(),
          buildInputPhone(),
        ],
      ),
    );
  }

  Widget buildInputName() {
    return TextFormField(
      initialValue: controller.currentUser.pessoa.nomeSobrenome,
      validator: (value) => controller.v.validatorNomeCompleto(value!, S.to.digiteNomeCompleto),
      decoration: InputDecoration(
        labelText: S.to.nomeCompleto,
      ),
      onChanged: (v)=> controller.name = v,
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget buildInputEmail() {
    return TextFormField(
      initialValue: controller.currentUser.pessoa.email,
      validator: (value) => controller.v.validatorEmail(value!, S.to.emailInvalido),
      decoration: InputDecoration(
        labelText: S.to.email,
      ),
      onChanged: (v)=> controller.email = v,
    );
  }

  Widget buildInputCpfCnpj() {
    return TextFormField(
      initialValue: controller.currentUser.pessoa.cpf,
      validator: (value) => value!.length == 14
          ? controller.v.validatorCpf(value, S.to.campoInvalido)
          : controller.v.validatorCNPJ(value, S.to.campoInvalido),
      decoration: InputDecoration(
        labelText: S.to.cpfCnpj,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CpfOuCnpjFormatter(),
      ],
      onChanged: (v)=> controller.document = UtilBrasilFields.removeCaracteres(v),
    );
  }

  Widget buildInputPhone() {
    return TextFormField(
      initialValue: controller.currentUser.pessoa.celular == null ? "" : controller.currentUser.pessoa.celular!.replaceAll(" 9 ", " 9"),
      validator: (value) => controller.v.validatorCelular(value!, S.to.telefoneInvalido, maskLenght: 15),
      decoration: InputDecoration(
        labelText: S.to.telefone,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TelefoneInputFormatter(),
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
      onChanged: (v){
        if(v.length > 12){
          controller.areaCode = UtilBrasilFields.obterDDD(v);
          controller.number = UtilBrasilFields.obterTelefone(UtilBrasilFields.removeCaracteres(v), mascara: false, ddd: false);
        }
      },
    );
  }

  Widget buildButtonConfirm() {
    return SizedBox(
      width: Responsive.to.width,
      child: ElevatedButton(
        onPressed: controller.confirm,
        child: Text(S.to.proximo),
      ),
    );
  }

}
