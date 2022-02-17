import 'package:arbo/app/modules/core/models/endereco.dart';
import 'package:arbo/app/modules/core/models/imagem.dart';
import 'package:arbo/app/modules/core/models/status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'info_usuario.dart';

class Arvore {
  late String id;
  late String nome;
  late String descricao;
  late InfoUsuario infoUsuario;
  bool produzindo = false;
  List<int> mesesProducao=[];

  late Endereco endereco;
  late Imagem imagem;

  Timestamp? dataCadastro;
  Timestamp? dataAlteracao;

  late String status;

  Arvore({
    required this.id,
    required this.infoUsuario,
    required this.nome,
    required this.descricao,
    required this.mesesProducao,
    this.status = Status.PENDENTE_ANALISE,

    required this.produzindo,
    required this.endereco,
    required this.imagem,
    this.dataAlteracao,
    this.dataCadastro,
  });

  Arvore.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    infoUsuario = InfoUsuario.fromJson(json['infoUsuario']);

    imagem = Imagem.fromJson(json['imagem']);
    endereco = Endereco.fromJson(json['endereco']);

    nome = json['nome'];
    descricao = json['descricao'];
    mesesProducao = json['mesesProducao'].cast<int>();
    produzindo = json['produzindo'];

    dataCadastro = json['dataCadastro'] is FieldValue ? null : json['dataCadastro'];
    dataAlteracao = json['dataAlteracao'] is FieldValue ? null : json['dataAlteracao'];

    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['mesesProducao'] = this.mesesProducao;
    data['produzindo'] = this.produzindo;
    data['status'] = this.status;

    data['infoUsuario'] = this.infoUsuario.toJson();
    data['endereco'] = this.endereco.toJson();
    data['imagem'] = this.imagem.toJson();

    data['dataCadastro'] = this.dataCadastro == null
        ? FieldValue.serverTimestamp()
        : this.dataCadastro;
    data['dataAlteracao'] = this.dataAlteracao == null
        ? FieldValue.serverTimestamp()
        : this.dataAlteracao;

    return data;
  }

  @override
  bool operator ==(other) {
   if(other is Arvore)
    return id == other.id;
   return false;
  }

}
