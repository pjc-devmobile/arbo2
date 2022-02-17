class Phones {
  Phone? homePhone;

  Phones({this.homePhone});

  Phones.fromJson(Map<String, dynamic> json) {
    homePhone = json['home_phone'] != null ? new Phone.fromJson(json['home_phone']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.homePhone != null) data['home_phone'] = this.homePhone!.toJson();
    return data;
  }
}

class Phone {
  late String countryCode;
  late String areaCode;
  late String number;

  Phone({required this.countryCode, required this.areaCode, required this.number});

  Phone.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    areaCode = json['area_code'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_code'] = this.countryCode;
    data['area_code'] = this.areaCode;
    data['number'] = this.number;
    return data;
  }
}
