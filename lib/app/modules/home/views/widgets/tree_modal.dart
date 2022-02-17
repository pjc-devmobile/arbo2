import 'package:arbo/app/modules/core/models/arvore.dart';
import 'package:arbo/app/modules/home/views/widgets/tree_details_dialog.dart';
import 'package:arbo/app/router_list.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:utils/utils/constants/colors.dart';

class TreeModal extends StatefulWidget {

  final Arvore tree;

  const TreeModal({required this.tree});

  @override
  _TreeModalState createState() => _TreeModalState();
}

class _TreeModalState extends State<TreeModal> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Responsive.to.prefPaddingSymmetric,
      child: SingleChildScrollView(
        child: Responsive.to.isPortrair ? buildPortrait() : buildLand(),
      ),
    );
  }

  Widget buildPortrait(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: Responsive.to.minPaddingSymmetricVertical,
          decoration: BoxDecoration(
            color: ColorsConfig.grey.withOpacity(0.3),
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          height: Responsive.to.prefPaddinHeight / 2,
          width: Responsive.to.oneUnitValueWidthScreen * 3,
        ),
        SizedBox(height: Responsive.to.prefPaddinHeight/2,),
        buildLocation(),
        SizedBox(height: Responsive.to.prefPaddinHeight/2,),
        buildImage(),
        SizedBox(height: Responsive.to.prefPaddinHeight/2,),
        buildInfoUser(),
      ],
    );
  }

  Widget buildLand(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: Responsive.to.minPaddingSymmetricVertical,
          decoration: BoxDecoration(
            color: ColorsConfig.grey.withOpacity(0.3),
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          height: Responsive.to.prefPaddinHeight / 2,
          width: Responsive.to.oneUnitValueWidthScreen * 3,
        ),
        SizedBox(height: Responsive.to.prefPaddinHeight/2,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: buildImage()),
            SizedBox(width: Responsive.to.prefPaddinWidth,),
            Expanded(
              child: Column(
                children: [
                  buildLocation(),
                  SizedBox(
                    height: Responsive.to.prefPaddinHeight / 2,
                  ),
                  SizedBox(
                    height: Responsive.to.prefPaddinHeight / 2,
                  ),
                  buildInfoUser(),
                ],
              ),
            )
          ],
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

  Widget buildImage(){
    return TextButton(
      onPressed: _showDetailsTree,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(Responsive.to.minPaddingSymmetricVertical)
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            color: ColorsConfig.grey.withOpacity(0.3),
            width: Responsive.to.widthWithoutPaddind,
            height: Responsive.to.oneUnitValueHeightScreen*5,
            child: CachedNetworkImage(
              imageUrl: widget.tree.imagem.url,
              height: Responsive.to.oneUnitValueHeightScreen*5,
              placeholder: (context, url) => Container(
                height: Responsive.to.oneUnitValueHeightScreen*3,
                child: Center(child: LinearProgressIndicator()),
              ),
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            width: Responsive.to.widthWithoutPaddind,
            padding: Responsive.to.minPaddingSymmetric,
            color: Colors.black38,
            child: Text(
              widget.tree.nome,
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.lightColor, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoUser(){
    return Row(
      children: [
        CircleAvatar(
          child: Icon(Icons.person),
        ),
        SizedBox(width: Responsive.to.prefPaddinWidth/2,),
        Expanded(child: Text(widget.tree.infoUsuario.nome, style: AppTextTheme.textTheme(),)),
        TextButton(onPressed: _showDetailsUser, child: Text(S.to.vermais, style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor),)),
      ],
    );
  }

  _showDetailsTree(){
    Modular.to.pop();

    showDialog(
      context: context,
      builder: (context) => TreeDetailsDialog(tree: widget.tree,),
      useRootNavigator: true,
    );
  }

  _showDetailsUser(){
    Modular.to.pop();
    Modular.to.pushNamed(RouterList.USER_MODULE, arguments: widget.tree.infoUsuario);
  }

}
