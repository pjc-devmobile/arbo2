class EstadoAtivo {

  late int arvoresPlantadas;
  late int arvoresMapeadas;
  late int arvoresProduzindo;
  late int cidadesAtivas;
  late int voluntariosColaborando;
  late int usuariosCadastrados;
  late String estado;  EstadoAtivo({
    required this.arvoresPlantadas,
    required this.arvoresMapeadas,
    required this.arvoresProduzindo,
    required this.cidadesAtivas,
    required this.voluntariosColaborando,
    required this.usuariosCadastrados,
    required this.estado,
  });

  EstadoAtivo.fromJson(Map<String, dynamic> json) {
    arvoresPlantadas = json['arvoresPlantadas'];
    arvoresMapeadas = json['arvoresMapeadas'];
    arvoresProduzindo = json['arvoresProduzindo'];
    cidadesAtivas = json['cidadesAtivas'];
    voluntariosColaborando = json['voluntariosColaborando'];
    usuariosCadastrados = json['usuariosCadastrados'];
    estado = json['estado'];
  }

  @override
  bool operator ==(Object other) {
    if (other is EstadoAtivo)
      return estado == other.estado;
    return false;
  }
}
