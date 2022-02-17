class ContaBancaria {
  String? idPagarme;
  String? agencia;
  String? agenciaDv;
  String? bankCode;
  String? conta;
  String? contaDv;
  String? documentNumber;
  String? legalName;
  String? type;

  ContaBancaria(
      {this.idPagarme,
        this.agencia,
        this.agenciaDv,
        this.bankCode,
        this.conta,
        this.contaDv,
        this.documentNumber,
        this.legalName,
        this.type});

  ContaBancaria.fromJson(Map<String, dynamic> json) {
    idPagarme = json['idPagarme'].toString();
    agencia = json['agencia'];
    agenciaDv = json['agencia_dv'];
    bankCode = json['bank_code'];
    conta = json['conta'];
    contaDv = json['conta_dv'];
    documentNumber = json['document_number'];
    legalName = json['legal_name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idPagarme'] = this.idPagarme;
    data['agencia'] = this.agencia;
    data['agencia_dv'] = this.agenciaDv;
    data['bank_code'] = this.bankCode;
    data['conta'] = this.conta;
    data['conta_dv'] = this.contaDv;
    data['document_number'] = this.documentNumber;
    data['legal_name'] = this.legalName;
    data['type'] = this.type;
    return data;
  }
}