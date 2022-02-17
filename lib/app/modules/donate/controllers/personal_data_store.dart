import 'package:arbo/app/modules/core/controllers/app_store.dart';
import 'package:arbo/app/modules/core/models/pagamento/customer.dart';
import 'package:arbo/app/modules/core/models/pagamento/metodo_pagamento.dart';
import 'package:arbo/app/modules/core/models/pagamento/phone.dart';
import 'package:arbo/app/modules/core/models/usuario.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:utils/utils.dart';

import '../../../router_list.dart';

part 'personal_data_store.g.dart';

class PersonalDataStore = _PersonalDataStoreBase with _$PersonalDataStore;

abstract class _PersonalDataStoreBase with Store {

  final _appStore = Modular.get<AppStore>();
  final v = Validator();

  final MetodoPagamento method;
  final double value;
  final formKey = GlobalKey<FormState>();

  String  name = "", email = "", type = "individual", document = "";
  String countryCode = "55", areaCode = "", number = "";

  _PersonalDataStoreBase({required this.method, required this.value}){
    name = currentUser.pessoa.nomeSobrenome;
    email = currentUser.pessoa.email == null ? "" : currentUser.pessoa.email!;
    document = currentUser.pessoa.cpf == null ? "" : currentUser.pessoa.cpf!;
    if(currentUser.pessoa.celular !=null){
      print("TTTTTTTTTTTTTTt: " + currentUser.pessoa.celular!.replaceAll(" 9 ", " 9"));
      areaCode = UtilBrasilFields.obterDDD(currentUser.pessoa.celular!.replaceAll(" 9 ", " 9"));
      number = UtilBrasilFields.obterTelefone(UtilBrasilFields.removeCaracteres(currentUser.pessoa.celular!), ddd: false, mascara: false);
    }
  }

  Usuario get currentUser => _appStore.currentUsuario!;

  void confirm() {
    if(!formKey.currentState!.validate())
      return;

    if(document.length == 11)
      type = "individual";
    else
      type = "company";

    Phones? phones;
    if(number.isNotEmpty){
      phones = Phones(homePhone: Phone(areaCode: areaCode, countryCode: countryCode, number: number));
    }
    Customer customer = Customer(name: name, email: email, type: type, document: document, phones: phones);

    Modular.to.pushNamed(RouterList.DONATE_PAY_PIX_BOLETO, arguments: {
      "method" : method,
      "value" : value,
      "customer" : customer,
    });
  }
}
