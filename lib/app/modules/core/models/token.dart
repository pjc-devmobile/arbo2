import 'package:cloud_firestore/cloud_firestore.dart';

class Tokens {
  String? id;
  List<String>? tokens;
  Timestamp? dataAlteracao;

  Tokens({this.id, this.tokens, this.dataAlteracao});

  Tokens.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tokens = json['tokens'].cast<String>();
    dataAlteracao =
        json['dataAlteracao'] is FieldValue ? null : json['dataAlteracao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tokens'] = this.tokens;
    data['dataAlteracao'] = this.dataAlteracao == null
        ? FieldValue.serverTimestamp()
        : this.dataAlteracao;
    return data;
  }
}
