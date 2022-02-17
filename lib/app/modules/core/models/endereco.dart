import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:utils/utils/util/location_utils.dart';

class Endereco {
  String? estado;
  String? cidade;
  String? endereco;
  String? cep;
  String? bairro;
  String? numero;
  String? complemento;
  Point? point;
  Timestamp? dataAlteracao;

  Endereco({
    this.estado,
    this.cidade,
    this.endereco,
    this.cep,
    this.numero,
    this.bairro,
    this.complemento,
    this.point,
    this.dataAlteracao,
  });

  Endereco.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return;

    estado = json['estado'];
    cidade = json['cidade'];
    endereco = json['endereco'];
    bairro = json['bairro'];
    cep = json['cep'];
    numero = json['numero'];
    complemento = json['complemento'];
    if (json['point'] != null) point = Point.fromJson(json['point']);
    dataAlteracao = json['dataAlteracao'] is FieldValue ? null : json['dataAlteracao'];
  }

  Map<dynamic, dynamic> toJson({bool comDataAlteracao = true}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['estado'] = this.estado;
    data['cidade'] = this.cidade;
    data['endereco'] = this.endereco;
    data['cep'] = this.cep;
    data['numero'] = this.numero;
    data['bairro'] = this.bairro;
    data['complemento'] = this.complemento;
    data['point'] = this.point == null ? null : this.point!.toJson();
    if (comDataAlteracao)
      data['dataAlteracao'] = this.dataAlteracao == null ? FieldValue.serverTimestamp() : this.dataAlteracao;
    return data;
  }

  @override
  String toString() {
    String toString = "$endereco, $numero, $bairro, $cep, $cidade-$estado";
    toString += complemento == null || complemento!.isEmpty ? "" : "\n$complemento";

    toString = toString.replaceAll("null, ", "");
    toString = toString.replaceAll("null-", "");
    toString = toString.replaceAll("-null", "");

    return toString;
  }

  String toStringParaEntregadores() {
    String toString = "$cep\n$endereco-$bairro, $numero\n$cidade-$estado";
    toString += complemento == null || complemento!.isEmpty ? "" : "\n$complemento";

    toString = toString.replaceAll("null, ", "");
    toString = toString.replaceAll("null-", "");
    toString = toString.replaceAll("-null", "");

    return toString;
  }

  String toStringSemEstado() {
    String toString = "$endereco, $numero, $cep, $cidade";

    toString = toString.replaceAll("null, ", "");
    toString = toString.replaceAll("null-", "");
    toString = toString.replaceAll("-null", "");

    return toString;
  }

  get cidadeNome {
    if (cidade == null) return "endereço não cadastrado";
    return cidade! + "-" + estado!;
  }

  LatLng get latLng => LatLng(point!.geopoint.latitude, point!.geopoint.longitude);

  @override
  bool operator ==(other) {
    // TODO: implement ==
    return toString() == (other.toString());
  }

  static Future<Endereco> fromAutoComplete(AutocompletePrediction autocomplete) async {
    var result = await LocationUtils.pesquisarEnderecos(autocomplete.description!);
    Address a = result[0];
    Endereco e = Endereco(
      endereco: a.thoroughfare,
      numero: a.subThoroughfare,
      cep: a.postalCode,
      cidade: a.subAdminArea,
      estado: a.adminArea,
      point: Point(geohash: "null", geopoint: GeoPoint(a.coordinates.latitude, a.coordinates.longitude)),
    );

    return e;
  }
}

class Point {
  late String geohash;
  late GeoPoint geopoint;

  Point({
    required this.geohash,
    required this.geopoint,
  });

  Point.fromJson(Map<dynamic, dynamic> json) {
    geohash = json['geohash'];
    geopoint = json['geopoint'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['geohash'] = this.geohash;
    data['geopoint'] = this.geopoint;
    return data;
  }
}
