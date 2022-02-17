class NotaAvaliacao {
  int? quantidadeAvaliacoes = 0;
  double? notaMedia = 5;

  NotaAvaliacao({this.quantidadeAvaliacoes, this.notaMedia});

  NotaAvaliacao.fromJson(Map<String, dynamic> json) {
    quantidadeAvaliacoes = json['quantidadeAvaliacoes'];
    notaMedia = double.parse(json['notaMedia'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantidadeAvaliacoes'] = this.quantidadeAvaliacoes;
    data['notaMedia'] = this.notaMedia;
    return data;
  }
}