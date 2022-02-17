import 'package:arbo/app/shared/components/custom_snack_barr.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';
import 'package:utils/utils/constants/colors.dart';
import 'package:utils/utils/util/utils.dart';

class BoletoWidget extends StatelessWidget {

  final dynamic boletoData;

  const BoletoWidget({Key? key, required this.boletoData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.to.boletoNoValorxgerado.replaceAll("x", Utils.formatarPreco(boletoData["amount"]/100)),
          style: AppTextTheme.textThemeBold(fontSize: 18),
        ),
        SizedBox(height: Responsive.to.prefPaddinHeight/2,),
        Text(
          S.to.vencimentoEm + " " + Utils.formatarData(DateTime.parse(boletoData["last_transaction"]["due_at"])),
          style: AppTextTheme.textThemeColor(color: ColorsConfig.grey),
        ),
        SizedBox(height: Responsive.to.prefPaddinHeight*2,),
        Text(S.to.utilizeNumeroCodigoBarrasParaRealizarPagameto),
        SizedBox(height: Responsive.to.prefPaddinHeight/2,),
        buildBarCodeNumber(),
        SizedBox(height: Responsive.to.prefPaddinHeight/2,),
        buildBarCode(),
        Spacer(),
        buildButtonCopy(),
      ],
    );
  }

  Widget buildBarCodeNumber(){
    return Card(
      color: ColorsConfig.greyLight,
      child: Container(
        width: Responsive.to.width,
        padding: Responsive.to.paddingMaxSymmetric,
        child: Text(
          boletoData["last_transaction"]["line"],
          style: AppTextTheme.textThemeBold(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
  
  Widget buildBarCode(){
    return Center(child: Image.network(boletoData["last_transaction"]["barcode"]));
  }

  Widget buildButtonCopy() {
    return SizedBox(
      width: Responsive.to.width,
      child: ElevatedButton(
        onPressed: (){
          FlutterClipboard.copy(boletoData["last_transaction"]["line"]).then((value){
            showCustomSnackBarrInfo(texto: S.to.codigoBarrasCopiado);
          });
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.copy),
            SizedBox(width: Responsive.to.prefPaddinWidth/2,),
            Text(S.to.copiarCodigo),
          ],
        ),
      ),
    );
  }

}
