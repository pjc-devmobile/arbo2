import 'package:cloud_firestore/cloud_firestore.dart';

class ObjetoDoChat {
  String? id;
  String? titulo;
  String? descricao;
  Timestamp? dataCadastro;
  Timestamp? dataAlteracao;

  ObjetoDoChat(
      {this.id,
        this.titulo,
        this.descricao,
        this.dataCadastro,
        this.dataAlteracao});

  ObjetoDoChat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    descricao = json['descricao'];

    dataCadastro = json['dataCadastro'] is FieldValue ? null : json['dataCadastro'];
    dataAlteracao = json['dataAlteracao'] is FieldValue ? null : json['dataAlteracao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;

    data['dataCadastro'] = this.dataCadastro == null
        ? FieldValue.serverTimestamp()
        : this.dataCadastro;
    data['dataAlteracao'] = this.dataAlteracao == null
        ? FieldValue.serverTimestamp()
        : this.dataAlteracao;
    return data;
  }
}