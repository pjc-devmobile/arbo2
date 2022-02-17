class App {
  late Versao android;
  late Versao ios;

  late int arvoresPlantadas;
  late int arvoresMapeadas;
  late int arvoresProduzindo;
  late int cidadesAtivas;
  late int voluntariosColaborando;
  late int usuariosCadastrados;
  late double reaisArrecadado; //Total
  late double reaisArrecadadoPix;
  late double reaisArrecadadoBoleto;

  App({
    required this.android,
    required this.ios,
    required this.arvoresPlantadas,
    required this.arvoresMapeadas,
    required this.arvoresProduzindo,
    required this.cidadesAtivas,
    required this.voluntariosColaborando,
    required this.usuariosCadastrados,
    required this.reaisArrecadado,
    required this.reaisArrecadadoPix,
    required this.reaisArrecadadoBoleto,
  });

  App.fromJson(Map<String, dynamic> json) {
    android = Versao.fromJson(json['android']);
    ios = Versao.fromJson(json['ios']);

    arvoresPlantadas = json['arvoresPlantadas'];
    arvoresMapeadas = json['arvoresMapeadas'];
    arvoresProduzindo = json['arvoresProduzindo'];
    cidadesAtivas = json['cidadesAtivas'];
    voluntariosColaborando = json['voluntariosColaborando'];
    usuariosCadastrados = json['usuariosCadastrados'];
    reaisArrecadado = double.parse(json['reaisArrecadado'].toString());

    reaisArrecadadoPix = double.parse(json['reaisArrecadadoPix'].toString());
    reaisArrecadadoBoleto = double.parse(json['reaisArrecadadoBoleto'].toString());
  }
}

class Versao {
  int? versaoApp;
  int? versaoMinima;
  String? link;
  String? melhorias;

  Versao({
    this.versaoApp,
    this.versaoMinima,
    this.link,
    this.melhorias,
  });

  Versao.fromJson(Map<String, dynamic> json) {
    versaoApp = json['versaoApp'];
    versaoMinima = json['versaoMinima'];
    link = json['link'];
    melhorias = json['melhorias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['versaoApp'] = this.versaoApp;
    data['versaoMinima'] = this.versaoMinima;
    data['link'] = this.link;
    data['melhorias'] = this.melhorias;
    return data;
  }
}
