import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Midia {
  late String id;
  late String tipo;
  late String url;
  String? urlMin;
  late String titulo;
  String? descricao;
  dynamic extra;
  File? arquivo; ///Dado localmente
  Timestamp? dataCadastro;
  Timestamp? dataAlteracao;

  Midia({
    required this.id,
    required this.tipo,
    required this.url,
    this.urlMin,
    required this.titulo,
    this.descricao,
    this.arquivo,
    this.extra,
    this.dataCadastro,
    this.dataAlteracao,
  });

  Midia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    extra = json['extra'];
    tipo = json['tipo'];
    url = json['url'];
    urlMin = json['urlMin'];
    descricao = json['descricao'];

    dataCadastro =
        json['dataCadastro'] is FieldValue ? null : json['dataCadastro'];
    dataAlteracao =
        json['dataAlteracao'] is FieldValue ? null : json['dataAlteracao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tipo'] = this.tipo;
    data['titulo'] = this.titulo;
    data['extra'] = this.extra;
    data['url'] = this.url;
    data['urlMin'] = this.urlMin;
    data['descricao'] = this.descricao;

    data['dataCadastro'] = this.dataCadastro == null
        ? FieldValue.serverTimestamp()
        : this.dataCadastro;
    data['dataAlteracao'] = FieldValue.serverTimestamp();
    return data;
  }

  static List<Midia> midiasFromDocs(List<DocumentSnapshot<Map<String, dynamic>>> docs) {
    List<Midia> midias = [];

    for (DocumentSnapshot<Map<String, dynamic>> doc in docs)
      midias.add(Midia.fromJson(doc.data()!));

    return midias;
  }

  @override
  bool operator ==(Object other) {
    if (other is Midia) return id == other.id;
    return false;
  }
}

class TipoMidia{
  static const String FOTO = "FOTO";
  static const String VIDEO = "VIDEO";

  static const String LINK_YOUTUBE = "LINK_YOUTUBE";
  static const String LINK_SITE = "LINK_SITE";
}
