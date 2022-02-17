import 'package:arbo/app/modules/core/models/pagamento/phone.dart';

class Customer {
  late String name;
  late String email;
  late String type;
  late String document;
  late Phones? phones;

  Customer({required this.name, required this.email, required this.type, required this.document, required this.phones});

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    type = json['type'];
    document = json['document'];
    phones =
    json['phones'] = new Phones.fromJson(json['phones']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['type'] = this.type;
    data['document'] = this.document;
    if(phones!=null)
      data['phones'] = this.phones!.toJson();
    return data;
  }
}