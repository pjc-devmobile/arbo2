import 'package:cloud_firestore/cloud_firestore.dart';

import 'info_usuario.dart';

class Avaliacao {
  String? id;
  String? avaliacao;
  double? nota;
  InfoUsuario? infoUsuario;
  Timestamp? dataCadastro;
  Timestamp? dataAlteracao;

  Avaliacao({
    this.id,
    this.avaliacao,
    this.nota,
    this.infoUsuario,
    this.dataCadastro,
    this.dataAlteracao,
  });

  Avaliacao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avaliacao = json['avaliacao'];
    nota = double.parse(json['nota'].toString());
    if (json['infoUsuario'] != null)
      infoUsuario = InfoUsuario.fromJson(json['infoUsuario']);

    dataCadastro = json['dataCadastro'] is FieldValue ? null : json['dataCadastro'];
    dataAlteracao = json['dataAlteracao'] is FieldValue ? null : json['dataAlteracao'];
  }

  Map<String, dynamic> toJson({bool todosCampos = true}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(todosCampos){
      data['infoUsuario'] = this.infoUsuario!.toJson();
    }

    data['id'] = this.id;
    data['avaliacao'] = this.avaliacao;
    data['nota'] = this.nota;

    data['dataCadastro'] = this.dataCadastro == null
        ? FieldValue.serverTimestamp()
        : this.dataCadastro;
    data['dataAlteracao'] = this.dataAlteracao == null
        ? FieldValue.serverTimestamp()
        : this.dataAlteracao;

    return data;
  }
}