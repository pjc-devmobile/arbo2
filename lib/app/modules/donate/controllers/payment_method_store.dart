import 'package:arbo/app/modules/core/controllers/app_store.dart';
import 'package:arbo/app/modules/core/models/app.dart';
import 'package:arbo/app/modules/core/models/pagamento/metodo_pagamento.dart';
import 'package:arbo/app/modules/start/controllers/start_store.dart';
import 'package:arbo/app/router_list.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'payment_method_store.g.dart';

class PaymentMethodStore = _PaymentMethodStoreBase with _$PaymentMethodStore;

abstract class _PaymentMethodStoreBase with Store{

  @observable
  MetodoPagamento? method;

  @action
  void setPaymentMethod(MetodoPagamento mp) => method = mp;

  void next(){
    Modular.to.pushNamed(RouterList.DONATE_VALUE_PAYMENT, arguments: method);
  }

}