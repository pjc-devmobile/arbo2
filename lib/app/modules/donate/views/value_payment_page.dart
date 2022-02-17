import 'package:arbo/app/modules/core/models/pagamento/metodo_pagamento.dart';
import 'package:arbo/app/modules/donate/controllers/value_payment_store.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils.dart';
import 'package:utils/utils/constants/colors.dart';

class ValuePaymentPage extends StatefulWidget {
  @override
  _ValuePaymentPageState createState() => _ValuePaymentPageState();
}

class _ValuePaymentPageState extends ModularState<ValuePaymentPage, ValuePaymentStore> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildHead(),
          Expanded(
            child: ListView(
              padding: Responsive.to.prefPaddingSymmetric,
              children: [
                buildMethodPaymnt(),
                SizedBox(
                  height: Responsive.to.prefPaddinHeight/2,
                ),
                buildValues(),
                SizedBox(
                  height: Responsive.to.prefPaddinHeight,
                ),
                bildInputValue(),
              ],
            ),
          ),
          Padding(
            padding: Responsive.to.prefPaddingSymmetric,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildButtonNext(),
              ],
            ),
          )
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
              S.to.valorDoacao,
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.lightColor, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMethodPaymnt(){
    return Text(S.to.metodoPagamentoSelecionado + " " + metodoPagamentoString(controller.method));
  }

  Widget buildValues() {
    return Column(
      children: [
        Row(
          children: [
            buildButtonValue(5),
            SizedBox(
              width: Responsive.to.prefPaddinWidth,
            ),
            buildButtonValue(10),
            SizedBox(
              width: Responsive.to.prefPaddinWidth,
            ),
            buildButtonValue(20),
          ],
        ),
        SizedBox(
          height: Responsive.to.prefPaddinHeight / 2,
        ),
        Row(
          children: [
            buildButtonValue(100),
            SizedBox(
              width: Responsive.to.prefPaddinWidth,
            ),
            buildButtonValue(500),
            SizedBox(
              width: Responsive.to.prefPaddinWidth,
            ),
            buildButtonValue(1000),
          ],
        ),
      ],
    );
  }

  Widget buildButtonValue(double value) {
    return Expanded(
      child: Observer(builder: (_) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: value == controller.value ? ColorsConfig.primaryColor : ColorsConfig.greyLight,
            onPrimary: value == controller.value ? null : ColorsConfig.primaryColor,
          ),
          onPressed: () => controller.setValue(value),
          child: Text(Utils.formatarPreco(value)),
        );
      }),
    );
  }

  Widget bildInputValue() {
    return Form(
      child: TextField(
        decoration: InputDecoration(
          labelText: S.to.desejaDoarOutroValor,
          hintText: S.to.valorDoacao,
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
        onChanged: (v)=> controller.setValue(UtilBrasilFields.converterMoedaParaDouble(v)),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          RealInputFormatter(centavos: true, moeda: true),
        ],
      ),
    );
  }

  Widget buildButtonNext() {
    return Observer(builder: (_) {
      return SizedBox(
        width: Responsive.to.width,
        child: ElevatedButton(
          onPressed: controller.value == 0 ? null : controller.next,
          child: Text(
            controller.value == 0
                ? S.to.proximo
                : S.to.pagarx.replaceAll("x", Utils.formatarPreco(controller.value)),
          ),
        ),
      );
    });
  }
}
