class Imagem {
  String? id;
  late String url;
  late String urlMin; //Url para a mesma imagem com resolução menor

  Imagem({
    this.id,
    required this.url,
    required this.urlMin,
  });

  Imagem.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    url = json['url'];
    urlMin = json['urlMin'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['urlMin'] = this.urlMin;
    return data;
  }

  @override
  bool operator ==(other) {
    if (other is Imagem) return this.url == (other.url);
    return false;
  }

  static List<Imagem> fotosFromJson(json) {
    List<Imagem> fotos = [];

    for (var item in json) fotos.add(Imagem.fromJson(item));

    return fotos;
  }
}
