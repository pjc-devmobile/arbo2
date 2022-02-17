import 'package:arbo/app/modules/donate/controllers/pay_pix_boleto_store.dart';
import 'package:arbo/app/modules/donate/controllers/payment_method_store.dart';
import 'package:arbo/app/modules/donate/controllers/personal_data_store.dart';
import 'package:arbo/app/modules/donate/controllers/value_payment_store.dart';
import 'package:arbo/app/modules/donate/views/paymentpixboleto/pay_pix_boleto_page.dart';
import 'package:arbo/app/modules/donate/views/payment_method_page.dart';
import 'package:arbo/app/modules/donate/views/personal_data_page.dart';
import 'package:arbo/app/modules/donate/views/value_payment_page.dart';
import 'package:arbo/app/router_list.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/donate_store.dart';
import 'views/donate_page.dart';

class DonateModule extends Module {

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DonateStore()),
    Bind.lazySingleton((i) => PaymentMethodStore()),
    Bind.lazySingleton((i) => ValuePaymentStore(i.args!.data)),
    Bind.lazySingleton((i) => PersonalDataStore(
          method: i.args!.data["method"],
          value: i.args!.data["value"],
        )),
    Bind.lazySingleton((i) => PayPixBoletoStore(
          method: i.args!.data["method"],
          value: i.args!.data["value"],
          customer: i.args!.data["customer"],
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => DonatePage()),
    ChildRoute(DonateRouters.PAYMENT_METHOD, child: (_, args) => PaymentMethodPage()),
    ChildRoute(DonateRouters.VALUE_PAYMENT, child: (_, args) => ValuePaymentPage()),
    ChildRoute(DonateRouters.PERSONAL_DATA, child: (_, args) => PersonalDataPage()),
    ChildRoute(DonateRouters.PAY_PIX_BOLETO, child: (_, args) => PayPixBoletoPage()),
  ];

}
