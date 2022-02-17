import 'package:cloud_firestore/cloud_firestore.dart';

import '../chat/mensagem.dart';
import '../chat/objeto_do_chat.dart';
import '../info_usuario.dart';

class Chat {
  String? id;

  ///Sempre será o mesmo id do objeto do chat
  Mensagem? ultimaMensagem;
  List<String>? idParticipantes;
  ObjetoDoChat? objetoDoChat;
  InfoUsuario? remetente;
  InfoUsuario? destinatario;
  Timestamp? remetenteDigitando;
  Timestamp? destinatarioDigitando;
  Timestamp? lidaRemetente;
  Timestamp? lidaDestinatario;
  Timestamp? dataCadastro;
  Timestamp? dataAlteracao;

  Chat({
    this.id,
    this.ultimaMensagem,
    this.idParticipantes,
    this.objetoDoChat,
    this.remetente,
    this.destinatario,
    this.remetenteDigitando,
    this.destinatarioDigitando,
    this.lidaRemetente,
    this.lidaDestinatario,
    this.dataCadastro,
    this.dataAlteracao,
  });

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ultimaMensagem = json['ultimaMensagem'] != null ? new Mensagem.fromJson(json['ultimaMensagem']) : null;
    idParticipantes = json['idParticipantes'].cast<String>();
    objetoDoChat = json['objetoDoChat'] != null ? new ObjetoDoChat.fromJson(json['objetoDoChat']) : null;
    remetente = json['remetente'] != null ? new InfoUsuario.fromJson(json['remetente']) : null;
    destinatario = json['destinatario'] != null ? new InfoUsuario.fromJson(json['destinatario']) : null;
    remetenteDigitando = json['remetenteDigitando'];
    destinatarioDigitando = json['destinatarioDigitando'];
    lidaRemetente = json['lidaRemetente'];
    lidaDestinatario = json['lidaDestinatario'];

    dataCadastro = json['dataCadastro'] is FieldValue ? null : json['dataCadastro'];
    dataAlteracao = json['dataAlteracao'] is FieldValue ? null : json['dataAlteracao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.ultimaMensagem != null) {
      data['ultimaMensagem'] = this.ultimaMensagem!.toJson();
    }
    data['idParticipantes'] = this.idParticipantes;
    if (this.objetoDoChat != null) {
      data['objetoDoChat'] = this.objetoDoChat!.toJson();
    }
    if (this.remetente != null) {
      data['remetente'] = this.remetente!.toJson();
    }
    if (this.destinatario != null) {
      data['destinatario'] = this.destinatario!.toJson();
    }
    data['remetenteDigitando'] = this.remetenteDigitando;
    data['destinatarioDigitando'] = this.destinatarioDigitando;
    data['lidaDestinatario'] = this.lidaDestinatario;
    data['lidaRemetente'] = this.lidaRemetente;

    data['dataCadastro'] = this.dataCadastro == null ? FieldValue.serverTimestamp() : this.dataCadastro;
    data['dataAlteracao'] = this.dataAlteracao == null ? FieldValue.serverTimestamp() : this.dataAlteracao;
    return data;
  }

  bool get salvoFirebase => dataCadastro != null;

  static List<Chat> chatsFromDocs(List<DocumentSnapshot<Map<String, dynamic>>> docs) {
    List<Chat> chats = [];

    for (DocumentSnapshot<Map<String, dynamic>> doc in docs) chats.add(Chat.fromJson(doc.data()!));

    return chats;
  }

  @override
  bool operator ==(other) {
    if (other is Chat) return id == other.id;

    return false;
  }
}
