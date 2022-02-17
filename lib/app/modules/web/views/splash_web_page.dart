import 'package:arbo/app/modules/web/controllers/splash_web_store.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashWebPage extends StatefulWidget {
  @override
  _SplashWebPageState createState() => _SplashWebPageState();
}

class _SplashWebPageState extends ModularState<SplashWebPage, SplashWebStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Responsive.to.heightWithoutPaddind,
        width: Responsive.to.widthWithoutPaddind,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/images/background.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Center(
          child: Image.asset(
            "assets/logo.png",
            width: Responsive.to.oneUnitValueWidthScreen * 3,
            height: Responsive.to.oneUnitValueHeightScreen * 3,
          ),
        ),
      ),
    );
  }
}
