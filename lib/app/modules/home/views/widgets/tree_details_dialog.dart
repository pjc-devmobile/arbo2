import 'package:arbo/app/modules/core/models/arvore.dart';
import 'package:arbo/app/modules/core/models/meses_util.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:utils/utils/constants/colors.dart';

class TreeDetailsDialog extends StatefulWidget {

  final Arvore tree;

  const TreeDetailsDialog({required this.tree});

  @override
  _TreeDetailsDialogState createState() => _TreeDetailsDialogState();
}

class _TreeDetailsDialogState extends State<TreeDetailsDialog> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildButtonClose(),
          Expanded(
            child: SingleChildScrollView(
              padding: Responsive.to.prefPaddingSymmetric,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tree.nome,
                    style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor, fontSize: 18),
                  ),
                  SizedBox(
                    height: Responsive.to.prefPaddinHeight / 2,
                  ),
                  buildImage(),
                  SizedBox(
                    height: Responsive.to.prefPaddinHeight / 2,
                  ),
                  buildInfoUser(),
                  Divider(),
                  buildDescription(),
                  Divider(),
                  buildProducing(),
                  Divider(),
                  buildLocation(),
                  SizedBox(
                    height: Responsive.to.prefPaddinHeight * 2,
                  ),
                  buildMonthsProducing(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButtonClose(){
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        icon: Icon(Icons.clear, color: ColorsConfig.primaryColor,),
        onPressed: () => Modular.to.pop(),
      ),
    );
  }

  Widget buildImage(){
    return Container(
      color: ColorsConfig.grey.withOpacity(0.3),
      width: Responsive.to.widthWithoutPaddind,
      child: CachedNetworkImage(
        imageUrl: widget.tree.imagem.url,
        placeholder: (context, url) => Container(
          height: Responsive.to.oneUnitValueHeightScreen*3,
          child: Center(child: LinearProgressIndicator()),
        ),
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget buildDescription(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.to.descricao, style: AppTextTheme.textThemeColor(color: ColorsConfig.primaryColor),),
        Text(
          widget.tree.descricao,
          style: AppTextTheme.textThemeColor(),
        ),
      ],
    );
  }

  Widget buildProducing(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.to.arvoreJaProduz, style: AppTextTheme.textThemeColor(color: ColorsConfig.primaryColor),),
        Text(
          widget.tree.produzindo ?S.to.sim :S.to.nao,
          style: AppTextTheme.textThemeColor(),
        ),
      ],
    );
  }

  Widget buildLocation(){
    return Row(
      children: [
        Icon(Icons.location_on, size: Responsive.to.oneUnitValueHeightScreen/2,),
        SizedBox(width: Responsive.to.prefPaddinWidth/2,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.tree.endereco.endereco!, style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor),),
            Text(widget.tree.endereco.cidadeNome, style: AppTextTheme.textThemeColor(color: ColorsConfig.primaryColor),),
          ],
        ),
      ],
    );
  }

  Widget buildInfoUser(){
    return Row(
      children: [
        CircleAvatar(
          radius: Responsive.to.oneUnitValueWidthScreen*.4,
          child: Icon(Icons.person, size: Responsive.to.oneUnitValueWidthScreen*.5,),
        ),
        SizedBox(width: Responsive.to.prefPaddinWidth/2,),
        Expanded(child: Text(widget.tree.infoUsuario.nome, style: AppTextTheme.textTheme(),)),
      ],
    );
  }

  Widget buildMonthsProducing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
         S.to.mesesDeProducao,
          style: AppTextTheme.textThemeColor(color: Colors.black87),
        ),

        ///Inicio e fim
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: null,
                child: Text(MesesUtil.MONTHS_NAME[widget.tree.mesesProducao[0]]),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(Responsive.to.minPaddingSymmetric),
                    minimumSize: MaterialStateProperty.all(Size(0, 0))),
              ),
            ),
            Container(
              margin: Responsive.to.prefPaddingSymmetric,
              color: ColorsConfig.primaryColor,
              width: Responsive.to.prefPaddinWidth * 6,
              height: 1,
            ),
            Expanded(
              child: OutlinedButton(
                onPressed: null,
                child: Text(MesesUtil.MONTHS_NAME[widget.tree.mesesProducao[1]]),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(Responsive.to.minPaddingSymmetric),
                    minimumSize: MaterialStateProperty.all(Size(0, 0))),
              ),
            ),
          ],
        ),
      ],
    );
  }

}
