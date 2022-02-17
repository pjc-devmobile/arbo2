import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class EstadoCidadesUtils {
  late String sigla;
  late String nome;
  List<dynamic>? cidades;

  EstadoCidadesUtils({required this.sigla, required this.nome, this.cidades});

  EstadoCidadesUtils.fromJson(Map<String, dynamic> json) {
    sigla = json['sigla'];
    nome = json['nome'];
    cidades = (json['cidades']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sigla'] = this.sigla;
    data['nome'] = this.nome;
    data['cidades'] = this.cidades;
    return data;
  }

  static Future<List<EstadoCidadesUtils>> loadAssetEstados() async {
    var value = await rootBundle.loadString('assets/jsons/estados_cidades.json');

    Map<String, dynamic> stringList = jsonDecode(value);
    List<dynamic> estadosJson = stringList.values.toList()[0];

    List<EstadoCidadesUtils> estadosCidades = [];
    for (var json in estadosJson) {
      estadosCidades.add(EstadoCidadesUtils.fromJson(json));
    }

    return estadosCidades;
  }
}
