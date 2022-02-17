import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/cupertino.dart';

import 'utils.dart';

class Validator {
  String? validatorPadrao(
    String value,
    erro,
  ) {
    if (value.isEmpty)
      return erro;
    else
      return null;
  }

  String? validatorCampoUnico(
    String value,
    bool existe,
    erro,
  ) {
    if (value.isEmpty || existe)
      return erro;
    else
      return null;
  }

  String? validatorCpf(String value, String erro) {
    if (CPFValidator.isValid(value))
      return null;
    else
      return erro;
  }

  String? validatorCNPJ(String value, String erro) {
    if (CNPJValidator.isValid(value))
      return null;
    else
      return erro;
  }

  String? validatorCelular(String value, String erro, {int maskLenght = 16 }) {
    if (value.length < maskLenght)
      return erro;
    else
      return null;
  }

  String? validatorFixo(String value, String erro) {
    if (value.length < 14)
      return erro;
    else
      return null;
  }

  String? validatorEmail(String value, String erro) {
    if (Utils.emailIsValid(value))
      return null;
    else
      return erro;
  }

  String? validatorConfirmaSenha(String value, String senha, String erro) {
    if (value == senha)
      return null;
    else
      return erro;
  }

  String? validatorSenha(String value, String erro) {
    if (value.length > 5)
      return null;
    else
      return erro;
  }

  String? validatorNomeCompleto(String value, String erro) {
    if (value.isEmpty || !value.contains(" ") || value.substring(value.indexOf(" ") + 1).isEmpty)
      return erro;
    else
      return null;
  }

  ///Permite que seja vazio
  String? validatorPrecoComVazio(String value, erro) {
    if (value.isEmpty)
      return null;
    else {
      try {
        value = value.replaceAll(("R\$ "), "");
        double.parse(value.replaceAll(",", "."));
      } catch (ex) {
        return erro;
      }
      return null;
    }
  }

  String? validatorPreco(String value, erro) {
    value = value.replaceAll(("R\$ "), "");
    if (value.isEmpty)
      return erro;
    else {
      try {
        double.parse(value.replaceAll(",", "."));
      } catch (ex) {
        return erro;
      }
      return null;
    }
  }

  String? validatorHora(String value, String erro) {
    if (value.isEmpty) return erro;
    if (value.length < 5) return erro;

    int hora = int.parse(value.substring(0, 2));
    int minuto = int.parse(value.substring(3));

    if (hora > 23 || minuto > 59) return erro;

    return null;
  }

  String? validatorInteiro(String value, erro) {
    if (value.isEmpty)
      return erro;
    else {
      try {
        int.parse(value);
      } catch (ex) {
        return erro;
      }
      return null;
    }
  }
}
