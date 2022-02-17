import 'package:arbo/app/modules/core/models/usuario.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:utils/utils.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:utils/utils/constants/colors.dart';

import 'users_store.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends ModularState<UsersPage, UsersStore> with SingleTickerProviderStateMixin {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _tabBarKey = GlobalKey();  TabController? tabController;

  @override
  void initState() {
    super.initState();

    if (tabController == null) tabController = new TabController(vsync: this, length: 2, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          buildHead(),
          SizedBox(
            height: Responsive.to.prefPaddinHeight * 2,
          ),
          buildTabBar(),
          Expanded(child: buildTabViews()),
        ],
      ),
    );
  }

  Widget buildHead() {
    return Container(
      width: Responsive.to.width,
      decoration: BoxDecoration(
        color: ColorsConfig.primaryColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36), bottomRight: Radius.circular(36)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Responsive.to.prefPaddinHeight * 1.5,
          horizontal: Responsive.to.prefPaddinWidth * 2,
        ),
        child: SafeArea(
          child: Text(
           S.to.usuariosCadastrados,
            style: AppTextTheme.textThemeColorBold(color: ColorsConfig.lightColor, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget buildTabBar() {
    return TabBar(
      key: _tabBarKey,
      controller: tabController,
      tabs: <Widget>[
        Tab(
          text:S.to.voluntariosColaborando + " (${controller.appStore.appInfoSync.voluntariosColaborando})",
        ),
        Tab(
          text:S.to.usuariosCadastrados + " (${controller.appStore.appInfoSync.usuariosCadastrados})",
        ),
      ],
      labelColor: Theme.of(context).primaryColor,
      unselectedLabelColor: Colors.black38,
      indicatorPadding: EdgeInsets.only(top: Responsive.to.prefPaddinHeight / 4),
      indicatorColor: Theme.of(context).primaryColor,
    );
  }

  Widget buildTabViews() {
    return Container(
      width: Responsive.to.width,
      child: TabBarView(
        controller: tabController,
        children: <Widget>[
          buildUsersVoluntaries(),
          buildAllUsers(),
        ],
      ),
    );
  }

  Widget buildUsersVoluntaries() {
    return Observer(builder: (_) {
      if (controller.usersVoluntary == null)
        return Padding(
          padding: Responsive.to.maxPaddingSymmetricVertical,
          child: Center(child: LinearProgressIndicator()),
        );

      return buildListUsers(controller.usersVoluntary!);
    });
  }

  Widget buildAllUsers() {
    return Observer(builder: (_) {
      if (controller.allUsers == null)
        return Padding(
          padding: Responsive.to.maxPaddingSymmetricVertical,
          child: Center(child: LinearProgressIndicator()),
        );

      return buildListUsers(controller.allUsers!);
    });
  }

  Widget buildListUsers(List drivers) {
    return ListView.builder(
      padding: Responsive.to.prefPaddingSymmetric,
      itemCount: drivers.length,
      itemBuilder: (contex, index) {
        return buildItemUser(drivers[index]);
      },
    );
  }

  ///Daqui pra baixo widgets de item de oferta

  Widget buildItemUser(Usuario user) {
    return Padding(
      padding: Responsive.to.minPaddingSymmetricVertical,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ColorsConfig.lightColor),
          padding: MaterialStateProperty.all(Responsive.to.prefPaddingSymmetric),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        onPressed: () {},
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: ColorsConfig.lightColor,
              radius: Responsive.to.prefPaddinHeight*2.5,
              foregroundColor: ColorsConfig.redDarktColor,
              child: Icon(
                Icons.person,
                color: ColorsConfig.primaryColor,
                size: Responsive.to.prefPaddinHeight*2.5,
              ),
            ),
            SizedBox(width: Responsive.to.prefPaddinWidth,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.pessoa.nomeSobrenome, style: AppTextTheme.textThemeColorBold(color: Colors.black87),),
                  SizedBox(height: Responsive.to.prefPaddinHeight/2,),
                  Text(user.pessoa.enderecoPrincipal!.cidadeNome, style: AppTextTheme.textThemeColor()),
                  SizedBox(height: Responsive.to.prefPaddinHeight/2,),
                  Text(TipoUsuario.tipoString(context, user.tipoUsuario), style: AppTextTheme.textThemeColor(color: ColorsConfig.primaryColor)),
                ],
              ),
            ),
            buildButtons(user),
          ],
        ),
      ),
    );
  }

  Widget buildButtons(Usuario user){
    return Column(
      children: [
        if (user.tipoUsuario != TipoUsuario.USUARIO)
          OutlinedButton(
            onPressed: ()=> controller.becomeUser(context, user),
            child: Text(S.to.tornarUsuarioComum),
          ),
        if (user.tipoUsuario != TipoUsuario.VOLUNTARIO)
          ElevatedButton(
            onPressed: ()=> controller.becomeVoluntary(context, user),
            child: Text(S.to.tornarVoluntario),
          )
      ],
    );
  }
}
