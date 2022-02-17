import 'package:arbo/app/modules/core/models/pagamento/metodo_pagamento.dart';
import 'package:arbo/app/modules/donate/controllers/payment_method_store.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils/constants/colors.dart';
import 'package:utils/utils/text/app_text_theme.dart';

class PaymentMethodPage extends StatefulWidget {
  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends ModularState<PaymentMethodPage, PaymentMethodStore> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildHead(),
          Expanded(
            child: ListView(
              children: [
                buildButtonMethod(Icon(FlutterIcons.barcode_ant), S.to.boleto, MetodoPagamento.boleto),
                /*buildButtonMethod(Icon(FlutterIcons.credit_card_alt_faw), S.to.cartaoCredito, MetodoPagamento.credit_card),*/
                buildButtonMethod(Image.asset(
                      "assets/icons/ic_pix.png",
                      width: Responsive.to.buttonMinimumHeight,
                    ), S.to.pix, MetodoPagamento.pix),
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
              S.to.escolhaMetodoDoacao,
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.lightColor, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtonMethod(Widget icon, String text, MetodoPagamento mp) {
    return Observer(builder: (_) {
      return ListTile(
        selected: controller.method == mp,
        leading: icon,
        title: Text(text),
        onTap: () => controller.setPaymentMethod(mp),
      );
    });
  }

  Widget buildButtonNext() {
    return Observer(builder: (_) {
      return SizedBox(
        width: Responsive.to.width,
        child: ElevatedButton(
          onPressed: controller.method == null ? null : controller.next,
          child: Text(S.to.proximo),
        ),
      );
    });
  }
}
