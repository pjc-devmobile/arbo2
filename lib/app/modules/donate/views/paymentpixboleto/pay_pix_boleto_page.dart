import 'dart:async';
import 'dart:convert';

import 'package:arbo/app/modules/core/models/pagamento/metodo_pagamento.dart';
import 'package:arbo/app/modules/donate/controllers/pay_pix_boleto_store.dart';
import 'package:arbo/app/modules/donate/views/paymentpixboleto/pix_widget.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils.dart';
import 'package:utils/utils/constants/colors.dart';
import 'package:utils/utils/text/app_text_theme.dart';

import 'boleto_widget.dart';

class PayPixBoletoPage extends StatefulWidget {
  @override
  _PayPixBoletoPageState createState() => _PayPixBoletoPageState();
}

class _PayPixBoletoPageState extends ModularState<PayPixBoletoPage, PayPixBoletoStore> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 100), () => controller.pay(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildHead(),
          Expanded(
            child: Observer(builder: (_) {
              if (controller.responseTransaction == null)
                return Center(
                  child: CircularProgressIndicator(),
                );

              if (controller.responseTransaction!["status"] == "failed")
                return Center(child: Text(S.to.ocorreuErroRealizarOperacao));

              if (controller.responseTransaction!["payment_method"] == "boleto")
                return Padding(
                  padding: Responsive.to.prefPaddingSymmetric,
                  child: BoletoWidget(boletoData: controller.responseTransaction),
                );
              else if (controller.responseTransaction!["payment_method"] == "pix") buildPix();
              return Padding(
                padding: Responsive.to.prefPaddingSymmetric,
                child: PixWidget(pixData: controller.responseTransaction),
              );
            }),
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
              metodoPagamentoString(controller.method) + " R\$ " + Utils.formatarPreco(controller.value),
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.lightColor, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPix() {
    return Text("dfd");
  }
}
