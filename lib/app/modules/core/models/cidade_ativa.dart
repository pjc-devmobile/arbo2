class CidadeAtiva {

  late int arvoresPlantadas;
  late int arvoresMapeadas;
  late int arvoresProduzindo;
  late String cidade;
  late int voluntariosColaborando;
  late int usuariosCadastrados;
  late String estado;  CidadeAtiva({
    required this.arvoresPlantadas,
    required this.arvoresMapeadas,
    required this.arvoresProduzindo,
    required this.cidade,
    required this.voluntariosColaborando,
    required this.usuariosCadastrados,
    required this.estado,
  });

  CidadeAtiva.fromJson(Map<String, dynamic> json) {
    arvoresPlantadas = json['arvoresPlantadas'];
    arvoresMapeadas = json['arvoresMapeadas'];
    arvoresProduzindo = json['arvoresProduzindo'];
    cidade = json['cidade'];
    voluntariosColaborando = json['voluntariosColaborando'];
    usuariosCadastrados = json['usuariosCadastrados'];
    estado = json['estado'];
  }

  @override
  bool operator ==(Object other) {
    if (other is CidadeAtiva)
      return cidade+"-"+estado == other.cidade+"-"+other.estado;
    return false;
  }
}
