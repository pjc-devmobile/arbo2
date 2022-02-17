import 'package:arbo/app/modules/core/models/pessoa.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';

class Usuario {
  late String id;
  late Pessoa pessoa;
  late int arvoresMapeadas;
  late int arvoresPlantadas;
  late int amigosConvidados;
  List<String>? permissoes;
  String? status;
  late String tipoUsuario;
  Timestamp? dataCadastro;

  Usuario({
    this.id = "",
    required this.pessoa,
    this.arvoresMapeadas = 0,
    this.arvoresPlantadas = 0,
    this.amigosConvidados = 0,
    this.permissoes,
    this.status,
    this.dataCadastro,
    required this.tipoUsuario,
  });

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pessoa = new Pessoa.fromJson(json['pessoa']);
    permissoes = json['permissoes'] == null ? [] : json['permissoes'].cast<String>();
    arvoresMapeadas = json['arvoresMapeadas'];
    arvoresPlantadas = json['arvoresPlantadas'];
    amigosConvidados = json['amigosConvidados'];
    status = json['status'];
    tipoUsuario = json['tipoUsuario'];
    dataCadastro = json['dataCadastro'] is FieldValue ? null : json['dataCadastro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pessoa'] = pessoa.toJson();
    data['permissoes'] = this.permissoes;
    data['status'] = this.status;
    data['arvoresMapeadas'] = this.arvoresMapeadas;
    data['arvoresPlantadas'] = this.arvoresPlantadas;
    data['amigosConvidados'] = this.amigosConvidados;
    data['tipoUsuario'] = this.tipoUsuario;
    data['dataCadastro'] = this.dataCadastro == null ? FieldValue.serverTimestamp() : this.dataCadastro;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (other is Usuario) return id == other.id;
    return false;
  }
}

class TipoUsuario {
  static const String USUARIO = "USUARIO";
  static const String ADM = "ADM";
  static const String VOLUNTARIO = "VOLUNTARIO";

  static String tipoString(BuildContext context, String tipo) {

    switch (tipo) {
      case USUARIO:
        return S.to.usuario;
      case ADM:
        return S.to.administrador;
      case VOLUNTARIO:
        return S.to.voluntario;
      default:
        return "";
    }
  }
}
