import 'package:arbo/app/modules/core/controllers/splash_store.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, SplashStore> {

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
