import 'package:arbo/app/modules/core/models/midia.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:utils/utils/constants/colors.dart';

import 'new_media_web_store.dart';

class NewMediaWebDialog extends StatefulWidget {
  @override
  _LearnReadWebPageState createState() => _LearnReadWebPageState();
}

class _LearnReadWebPageState extends ModularState<NewMediaWebDialog, NewMediaWebStore> {
  

  final _formKey = GlobalKey<FormState>();  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: Responsive.to.heightWithoutPaddind-Responsive.to.prefPaddinHeight*6,
              padding: Responsive.to.prefPaddingSymmetric,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      (controller.media == null ?S.to.novaMidia :S.to.editarMidia) +
                          " - " +
                          (controller.mediaType == TipoMidia.LINK_YOUTUBE ?S.to.paraAssistir :S.to.paraLer),
                      style: AppTextTheme.textThemeColorBold(color: Colors.black87, fontSize: 18),
                    ),
                  ),
                  SizedBox(height: Responsive.to.prefPaddinHeight,),
                  buildForm(),
                  SizedBox(height: Responsive.to.prefPaddinHeight*2,),
                  buildImage(),
                  SizedBox(height: Responsive.to.prefPaddinHeight*2,),
                  Spacer(),
                  buildButtons(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(icon: Icon(Icons.clear), onPressed: () => Modular.to.pop()),
            )
          ],
        ),
      ),
    );
  }
  
  Widget buildForm(){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ///Titulo
          TextFormField(
            initialValue: controller.title,
            onChanged: (value) => controller.setProperty(title: value),
            textCapitalization: TextCapitalization.sentences,
            validator: (value) => Validator().validatorPadrao(value!,S.to.campoInvalido),
            decoration: InputDecoration(
              labelText:S.to.title,
            ),
          ),

          ///Descricao
          TextFormField(
            initialValue: controller.description,
            onChanged: (value) => controller.setProperty(description: value),
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText:S.to.descricao,
            ),
          ),

          ///Url
          TextFormField(
            initialValue: controller.url,
            onChanged: (value) => controller.setProperty(url: value),
            keyboardType: TextInputType.url,
            validator: (value) => Validator().validatorPadrao(value!,S.to.campoInvalido),
            decoration: InputDecoration(
              labelText: controller.mediaType == TipoMidia.LINK_YOUTUBE ?S.to.linkVideoYoutube :S.to.linkNoticia,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(S.to.imagem),
          SizedBox(
            height: Responsive.to.prefPaddinHeight / 2,
          ),
          ElevatedButton(
            onPressed: controller.chooseImage,
            style: ButtonStyle(
              padding: MaterialStateProperty.all(Responsive.to.minPaddingSymmetric),
            ),
            child: Observer(builder: (_) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: controller.image == null && controller.bytesImage == null
                    ? SizedBox(
                        height: Responsive.to.prefPaddinHeight * 10,
                        width: Responsive.to.prefPaddinHeight * 15,
                        child: Icon(
                          Icons.image,
                          size: Responsive.to.prefPaddinHeight * 3,
                        ),
                      )
                    : controller.image == null
                        ? Image.memory(
                            controller.bytesImage!,
                            height: Responsive.to.prefPaddinHeight * 10,
                            width: Responsive.to.prefPaddinHeight * 15,
                          )
                        : Image.file(
                            controller.image!,
                            height: Responsive.to.prefPaddinHeight * 10,
                            width: Responsive.to.prefPaddinHeight * 15,
                          ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildButtons(){
    return Row(
      children: [
        Spacer(),
        OutlinedButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(ColorsConfig.redDarktColor),
            minimumSize: MaterialStateProperty.all(Size(Responsive.to.prefPaddinWidth * 10, 0)),
          ),
          onPressed: () => Modular.to.pop(),
          child: Text(S.to.cancelar),
        ),
        SizedBox(
          width: Responsive.to.prefPaddinWidth,
        ),
        Observer(builder: (_) {
          return ElevatedButton(
            onPressed: controller.fieldsFill ? () => controller.save(_formKey, context) : null,
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(Responsive.to.prefPaddinWidth * 10, 0))),
            child: Text(S.to.salvar),
          );
        }),
      ],
    );
  }
}
