import 'dart:collection';
import 'dart:convert';

import 'package:arbo/app/modules/core/controllers/app_store.dart';
import 'package:arbo/app/modules/core/models/app.dart';
import 'package:arbo/app/modules/core/models/pagamento/customer.dart';
import 'package:arbo/app/modules/core/models/pagamento/metodo_pagamento.dart';
import 'package:arbo/app/modules/core/repositories/pagamento_repository.dart';
import 'package:arbo/app/modules/start/controllers/start_store.dart';
import 'package:arbo/app/router_list.dart';
import 'package:arbo/app/shared/components/custom_snack_barr.dart';
import 'package:arbo/app/shared/components/progress_dialog.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'pay_pix_boleto_store.g.dart';

class PayPixBoletoStore = _PayPixBoletoStoreBase with _$PayPixBoletoStore;

abstract class _PayPixBoletoStoreBase with Store {
  final _repository = PagamentoRepository();

  final MetodoPagamento method;
  final double value;
  final Customer customer;

  @observable
  dynamic responseTransaction;

  _PayPixBoletoStoreBase({required this.method, required this.value, required this.customer});

  @action
  void pay(BuildContext context) {
    showProgressDialog(context, title: S.to.processando);

    _repository.createPayment({
      "amount": (value * 100).toInt().toString(),
      "customer": customer.toJson(),
      "paymentMethod": method.toString().replaceAll("MetodoPagamento.", ""),
    }).then((value) {
      Modular.to.pop();
      responseTransaction = value["body"];
    }).catchError((err) {
      showCustomSnackBarrError(texto: err.toString(), duration: 7000);
      Modular.to.pop();
    });
  }
}
