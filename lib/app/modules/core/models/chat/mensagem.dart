import 'package:cloud_firestore/cloud_firestore.dart';

import '../midia.dart';

class Mensagem {
  String? id;
  String? idChat;
  List<String>? idParticipantes;
  String? idRemetente;
  String? nomeRemetente;
  String? mensagem;
  Midia? midia;
  Timestamp? dataCadastro;
  Timestamp? dataAlteracao;

  Mensagem({
    this.id,
    this.idChat,
    this.idRemetente,
    this.nomeRemetente,
    this.mensagem,
    this.idParticipantes,
    this.midia,
    this.dataCadastro,
    this.dataAlteracao,
  });

  Mensagem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idChat = json['idChat'];
    idRemetente = json['idRemetente'];
    nomeRemetente = json['nomeRemetente'];
    idParticipantes = json['idParticipantes'].cast<String>();
    mensagem = json['mensagem'];
    midia = json['midia'] != null ? new Midia.fromJson(json['midia']) : null;

    dataCadastro =
    json['dataCadastro'] is FieldValue ? null : json['dataCadastro'];
    dataAlteracao =
    json['dataAlteracao'] is FieldValue ? null : json['dataAlteracao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idChat'] = this.idChat;
    data['idRemetente'] = this.idRemetente;
    data['nomeRemetente'] = this.nomeRemetente;
    data['idParticipantes'] = this.idParticipantes;
    data['mensagem'] = this.mensagem;
    if (this.midia != null) {
      data['midia'] = this.midia!.toJson();
    }

    data['dataCadastro'] = this.dataCadastro == null
        ? FieldValue.serverTimestamp()
        : this.dataCadastro;
    data['dataAlteracao'] = this.dataAlteracao == null
        ? FieldValue.serverTimestamp()
        : this.dataAlteracao;

    return data;
  }

  static List<Mensagem> mensagensFromDocs(List<DocumentSnapshot<Map<String, dynamic>>> docs) {
    List<Mensagem> mensagens = [];

    for (DocumentSnapshot<Map<String, dynamic>> doc in docs)
      mensagens.add(Mensagem.fromJson(doc.data()!));

    return mensagens;
  }

  @override
  bool operator ==(other) {
    if (other is Mensagem)
      return id == other.id;

    return false;
  }
}