import 'package:arbo/l10n/app_localization.dart';

enum MetodoPagamento {
  boleto, credit_card, pix
}

String metodoPagamentoString(MetodoPagamento mp){
  if(mp == MetodoPagamento.boleto)
    return S.to.boleto;
  else if(mp == MetodoPagamento.pix)
    return S.to.pix;
  else if(mp == MetodoPagamento.credit_card)
    return S.to.cartaoCredito;

  return "";
}