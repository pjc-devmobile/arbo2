import 'package:cloud_firestore/cloud_firestore.dart';

class Notificacao {
  String? id;
  String? topico;

  ///Ou tópico ou destinatário devem ser null
  String? destinatario;

  ///Ou tópico ou destinatário devem ser null
  String? titulo;
  String? descricao;
  String? tipo;
  bool? lida;
  Map<dynamic, dynamic>? extra;
  Timestamp? data;

  Notificacao({
    this.id,
    this.topico,
    this.destinatario,
    this.titulo,
    this.descricao,
    this.tipo,
    this.lida,
    this.extra,
    this.data,
  });

  Notificacao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topico = json['topico'];
    destinatario = json['destinatario'];
    titulo = json['titulo'];
    descricao = json['descricao'];
    tipo = json['tipo'];
    extra = json['extra'];
    data = json['data'] is FieldValue ? null : json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['topico'] = this.topico;
    data['destinatario'] = this.destinatario;
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;
    data['tipo'] = this.tipo;
    data['extra'] = this.extra;
    data['data'] = this.data == null ? FieldValue.serverTimestamp() : this.data;

    return data;
  }
}

class TipoNotificacao {
  static const String CADASTRO_PEDIDO = "CADASTRO_PEDIDO";
  static const String ALTERACAO_PEDIDO = "ALTERACAO_PEDIDO";
}
