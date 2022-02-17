import 'endereco.dart';
import 'imagem.dart';

class InfoUsuario {
  late String id;
  String? idRecebedorPagarme;
  late String nome;
  String? celular;
  String? tipoUsuario;
  Imagem? imagem;
  Endereco? endereco;

  InfoUsuario({
    required this.id,
    this.idRecebedorPagarme,
    required this.nome,
    this.celular,
    this.endereco,
    this.tipoUsuario,
  });

  InfoUsuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idRecebedorPagarme = json['idRecebedorPagarme'];
    nome = json['nome'];
    celular = json['celular'];
    tipoUsuario = json['tipoUsuario'];
    endereco = Endereco.fromJson(json['endereco']);
    if (json['imagem'] != null) imagem = Imagem.fromJson(json['imagem']);
  }

  Map<String, dynamic> toJson({bool comDataAlteracao = true}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (idRecebedorPagarme != null)
      data['idRecebedorPagarme'] = this.idRecebedorPagarme;
    data['nome'] = this.nome;
    data['celular'] = this.celular;
    data['tipoUsuario'] = this.tipoUsuario;
    data['endereco'] = this.endereco == null ? null :this.endereco!.toJson(comDataAlteracao: comDataAlteracao);
    if (imagem != null) data['imagem'] = this.imagem!.toJson();
    return data;
  }
}