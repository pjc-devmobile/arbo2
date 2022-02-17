import 'package:arbo/app/modules/core/models/usuario.dart';
import 'package:arbo/app/modules/web/modules/start/views/start_web_store.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:utils/utils/constants/colors.dart';

class StartWebPage extends StatefulWidget {
  @override
  _StartWebPageState createState() => _StartWebPageState();
}

class _StartWebPageState extends ModularState<StartWebPage, StartWebStore>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Row(
        children: [
          buildMenuLeft(),
          Expanded(
            child: RouterOutlet(),
          ),
        ],
      ),
    );
  }

  Widget buildMenuLeft() {
    return Container(
      color: ColorsConfig.primaryColor,
      width: Responsive.to.buttonExtraLargeHeight*4,
      height: Responsive.to.heightWithoutPaddind,
      child: Column(
        children: [
          Container(
            width: Responsive.to.buttonExtraLargeHeight*4,
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.to.prefPaddinWidth / 2,
              vertical: Responsive.to.prefPaddinHeight,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage("assets/images/background.png"), repeat: ImageRepeat.repeatX),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  CircleAvatar(
                    foregroundColor: ColorsConfig.primaryColor,
                    backgroundColor: ColorsConfig.lightColor,
                    child: Icon(Icons.person),
                  ),
                  SizedBox(
                    width: Responsive.to.prefPaddinWidth / 2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.currentUsuario.pessoa.nomeSobrenome,
                        style: AppTextTheme.textThemeColorBold(color: ColorsConfig.lightColor),
                      ),
                      Text(
                        controller.currentUsuario.pessoa.email!,
                        style: AppTextTheme.textThemeColor(color: ColorsConfig.lightColor),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          buildTabs(),
          SizedBox(
            height: Responsive.to.prefPaddinHeight * 0.75,
          ),
          buildButtonSignout(),
        ],
      ),
    );
  }

  Widget buildTabs() {
    return Observer(builder: (_) {
      return Column(
        children: [
          ///árvores mapeadas
          Container(
            width: Responsive.to.widthWithoutPaddind,
            color: controller.currentIndex == StartWebIndexs.HOME_INDEX ? Colors.black26 : null,
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
              onPressed: () => controller.switchTab(StartWebIndexs.HOME_INDEX),
              child: Row(
                children: [
                  Icon(Icons.map),
                  SizedBox(
                    width: Responsive.to.prefPaddinWidth / 3,
                  ),
                  Text(S.to.arvoresMapeadas),
                ],
              ),
            ),
          ),

          ///Árvores pendentes
          Container(
            width: Responsive.to.widthWithoutPaddind,
            color: controller.currentIndex == StartWebIndexs.TREE_PENDING_INDEX ? Colors.black26 : null,
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
              onPressed: () => controller.switchTab(StartWebIndexs.TREE_PENDING_INDEX),
              child: Row(
                children: [
                  Icon(Icons.nature),
                  SizedBox(
                    width: Responsive.to.prefPaddinWidth / 3,
                  ),
                  Text(S.to.arvoresPendentes),
                ],
              ),
            ),
          ),

          ///Cidades ativas
          Container(
            width: Responsive.to.widthWithoutPaddind,
            color: controller.currentIndex == StartWebIndexs.STATES_ACTIVE_INDEX ? Colors.black26 : null,
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
              onPressed: () => controller.switchTab(StartWebIndexs.STATES_ACTIVE_INDEX),
              child: Row(
                children: [
                  Icon(Icons.location_city),
                  SizedBox(
                    width: Responsive.to.prefPaddinWidth / 3,
                  ),
                  Text(S.to.cidadesAtivas),
                ],
              ),
            ),
          ),

          ///Aprender
          if (controller.currentUsuario.tipoUsuario == TipoUsuario.ADM)
            Container(
              width: Responsive.to.widthWithoutPaddind,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
                onPressed: () => controller.switchTab(StartWebIndexs.LEARN_READ_INDEX),
                child: Row(
                  children: [
                    Icon(Icons.menu_book),
                    SizedBox(
                      width: Responsive.to.prefPaddinWidth / 3,
                    ),
                    Text(S.to.aprenda),
                  ],
                ),
              ),
            ),

          ///Aprender lendo
          if (controller.currentIndex == StartWebIndexs.LEARN_READ_INDEX ||
              controller.currentIndex == StartWebIndexs.LEARN_WATCH_INDEX)
            Container(
              width: Responsive.to.widthWithoutPaddind,
              color: controller.currentIndex == StartWebIndexs.LEARN_READ_INDEX ? Colors.black26 : null,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
                onPressed: () => controller.switchTab(StartWebIndexs.LEARN_READ_INDEX),
                child: Row(
                  children: [
                    SizedBox(
                      width: Responsive.to.prefPaddinWidth,
                    ),
                    Icon(Icons.library_books),
                    SizedBox(
                      width: Responsive.to.prefPaddinWidth / 3,
                    ),
                    Text(S.to.paraLer),
                  ],
                ),
              ),
            ),

          ///Aprender assistindo
          if (controller.currentIndex == StartWebIndexs.LEARN_READ_INDEX ||
              controller.currentIndex == StartWebIndexs.LEARN_WATCH_INDEX)
            Container(
              width: Responsive.to.widthWithoutPaddind,
              color: controller.currentIndex == StartWebIndexs.LEARN_WATCH_INDEX ? Colors.black26 : null,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
                onPressed: () => controller.switchTab(StartWebIndexs.LEARN_WATCH_INDEX),
                child: Row(
                  children: [
                    SizedBox(
                      width: Responsive.to.prefPaddinWidth,
                    ),
                    Icon(Icons.ondemand_video),
                    SizedBox(
                      width: Responsive.to.prefPaddinWidth / 3,
                    ),
                    Text(S.to.paraAssistir),
                  ],
                ),
              ),
            ),

          ///Usuários
          if (controller.currentUsuario.tipoUsuario == TipoUsuario.ADM)
            Container(
              width: Responsive.to.widthWithoutPaddind,
              color: controller.currentIndex == StartWebIndexs.USERS_INDEX ? Colors.black26 : null,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
                onPressed: () => controller.switchTab(StartWebIndexs.USERS_INDEX),
                child: Row(
                  children: [
                    Icon(Icons.group),
                    SizedBox(
                      width: Responsive.to.prefPaddinWidth / 3,
                    ),
                    Text(S.to.usuariosCadastrados),
                  ],
                ),
              ),
            ),
        ],
      );
    });
  }

  Widget buildButtonSignout() {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
      ),
      onPressed: () => controller.logOff(context),
      child: Row(
        children: [
          Icon(Icons.exit_to_app),
          SizedBox(
            width: Responsive.to.prefPaddinWidth / 3,
          ),
          Text(S.to.sair),
        ],
      ),
    );
  }
}
