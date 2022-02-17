import 'package:arbo/app/modules/core/controllers/app_store.dart';
import 'package:arbo/app/modules/core/models/app.dart';
import 'package:arbo/app/modules/core/models/pagamento/metodo_pagamento.dart';
import 'package:arbo/app/modules/start/controllers/start_store.dart';
import 'package:arbo/app/router_list.dart';
import 'package:arbo/app/shared/components/custom_snack_barr.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'value_payment_store.g.dart';

class ValuePaymentStore = _ValuePaymentStoreBase with _$ValuePaymentStore;

abstract class _ValuePaymentStoreBase with Store{

  final MetodoPagamento method;

  @observable
  double value = 0;

  _ValuePaymentStoreBase(this.method);

  @action
  void setValue(double v) => value = v;

  void next(){
    if(value<5){
      showCustomSnackBarrError(texto: S.to.valorMinimoFormaPagamentoInvalido);
      return;
    }

    Modular.to.pushNamed(RouterList.DONATE_PERSONAL_DATA, arguments: {
      "method" : method,
      "value" : value,
    });
  }

}