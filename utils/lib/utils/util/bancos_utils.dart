import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class BancoUtils {
  String? codigo;
  String? nome;

  BancoUtils({this.codigo, this.nome});

  BancoUtils.fromJson(Map<String, dynamic> json) {
    codigo = json['value'];
    nome = json['label'];
  }

  static Future<List<BancoUtils>> loadAssetBanks() async {
    var value = await rootBundle.loadString('assets/jsons/banks.json');

    Map<String, dynamic> stringList = jsonDecode(value);
    List<dynamic> bancosJson = stringList.values.toList()[0];

    List<BancoUtils> bancos = [];
    for (var json in bancosJson) bancos.add(BancoUtils.fromJson(json));

    return bancos;
  }

  static const String CONTA_POUPANCA = "conta_poupanca";
  static const String CONTA_CORRENTE = "conta_corrente";
}