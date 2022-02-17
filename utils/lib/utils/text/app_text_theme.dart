import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants/colors.dart';

class AppTextTheme{

  static TextStyle textTheme({double fontSize = 14}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      color: ColorsConfig.greyDark,
      fontSize: fontSize,
    );
  }

  static TextStyle textThemeColor({double fontSize = 14, Color color = ColorsConfig.greyDark}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      color: color,
      fontSize: fontSize,
    );
  }

  static TextStyle textThemeColorBold({double fontSize = 14, Color color = ColorsConfig.greyDark}) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle textThemeBold({double fontSize = 14}) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black.withOpacity(0.85),
      fontSize: fontSize,
    );
  }

  static TextStyle textThemeLight({double fontSize = 14}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      color: ColorsConfig.lightColor,
      fontSize: fontSize,
    );
  }

  static TextStyle textThemeLightBold({double fontSize = 14}) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: ColorsConfig.lightColor,
      fontSize: fontSize,
    );
  }

  static TextStyle textThemePrimary({double fontSize = 14}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      color: ColorsConfig.primaryColor,
      fontSize: fontSize,);
  }
}