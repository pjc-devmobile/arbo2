
import 'endereco.dart';
import 'imagem.dart';

class Pessoa {
  late String nome;
  late String sobrenome;
  late String nomeSobrenomeMaiusculo;
  String? cpf;
  String? rg;
  String? orgaoEmissor;
  String? celular;
  String? email;
  String? genero;
  Endereco? enderecoPrincipal;
  Imagem? imgPerfil;

  Pessoa({required this.nome,
        required this.sobrenome,
        this.cpf,
        this.rg,
        this.orgaoEmissor,
        this.celular,
        this.email,
        this.genero,
        this.enderecoPrincipal,
        this.imgPerfil});

  Pessoa.fromJson(Map<dynamic, dynamic> json) {
    nome = json['nome'];
    sobrenome = json['sobrenome'];
    nomeSobrenomeMaiusculo = json['nomeSobrenomeMaiusculo'];
    cpf = json['cpf'];
    rg = json['rg'];
    orgaoEmissor = json['orgaoEmissor'];
    celular = json['celular'];
    email = json['email'];
    genero = json['genero'];
    enderecoPrincipal = json['enderecoPrincipal'] == null? null :Endereco.fromJson(json['enderecoPrincipal']);
    imgPerfil = json['imgPerfil'] == null ? null :Imagem.fromJson(json['imgPerfil']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['sobrenome'] = this.sobrenome;
    data['nomeSobrenomeMaiusculo'] = nomeSobrenome.toUpperCase();
    data['cpf'] = this.cpf;
    data['rg'] = this.rg;
    data['orgaoEmissor'] = this.orgaoEmissor;
    data['celular'] = this.celular;
    data['email'] = this.email;
    data['genero'] = this.genero;
    data['imgPerfil'] = this.imgPerfil==null? null :this.imgPerfil!.toJson();
    data['enderecoPrincipal'] = this.enderecoPrincipal==null? null :this.enderecoPrincipal!.toJson();
    return data;
  }

 String get nomeSobrenome{
    return nome + " " + sobrenome;
  }
}