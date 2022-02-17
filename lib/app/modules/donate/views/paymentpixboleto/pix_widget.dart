import 'dart:convert';

import 'package:arbo/app/shared/components/custom_snack_barr.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';
import 'package:utils/utils/constants/colors.dart';
import 'package:utils/utils/util/utils.dart';

class PixWidget extends StatelessWidget {

  final dynamic pixData;

  const PixWidget({Key? key, required this.pixData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.to.pixNoValorxgerado.replaceAll("x", Utils.formatarPreco(pixData["amount"]/100)),
          style: AppTextTheme.textThemeBold(fontSize: 18),
        ),
        SizedBox(height: Responsive.to.prefPaddinHeight/2,),
        Text(
          S.to.vencimentoEm + " " + Utils.formatarData(DateTime.parse(pixData["last_transaction"]["expires_at"])),
          style: AppTextTheme.textThemeColor(color: ColorsConfig.grey),
        ),
        SizedBox(height: Responsive.to.prefPaddinHeight*2,),
        Text(S.to.utilizeQRCodeAbaixoOuCopieCodigo),
        SizedBox(height: Responsive.to.prefPaddinHeight/2,),
        buildBarCode(),
        SizedBox(height: Responsive.to.prefPaddinHeight/2,),
        buildBarCodeNumber(),
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
          pixData["last_transaction"]["qr_code"],
          style: AppTextTheme.textThemeBold(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
  
  Widget buildBarCode(){
    return Center(child: Image.network(pixData["last_transaction"]["qr_code_url"]));
  }

  Widget buildButtonCopy() {
    return SizedBox(
      width: Responsive.to.width,
      child: ElevatedButton(
        onPressed: (){
          FlutterClipboard.copy(pixData["last_transaction"]["qr_code"]).then((value){
            showCustomSnackBarrInfo(texto: S.to.codigoCopiado);
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
