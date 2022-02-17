import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:utils/utils/constants/colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    primarySwatch: MaterialColor(ColorsConfig.secondColor.value, {
      50: Color.fromRGBO(52, 99, 76, .1),
      100: Color.fromRGBO(52, 99, 76, .2),
      200: Color.fromRGBO(52, 99, 76, .3),
      300: Color.fromRGBO(52, 99, 76, .4),
      400: Color.fromRGBO(52, 99, 76, .5),
      500: Color.fromRGBO(52, 99, 76, .6),
      600: Color.fromRGBO(52, 99, 76, .7),
      700: Color.fromRGBO(52, 99, 76, .8),
      800: Color.fromRGBO(52, 99, 76, .9),
      900: Color.fromRGBO(52, 99, 76, 1),
    }),
    brightness: ColorsConfig.brightness,
    textTheme: new TextTheme(
      bodyText1: TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: ColorsConfig.greyDark),
      //body1: new TextStyle(color: Colors.red),
      // display4: new TextStyle(fontSize: 78),
      //button: new TextStyle(color: Colors.green),
      //headline: new TextStyle(color: Colors.deepPurple)
    ),
    // tabBarTheme:
    // accentIconTheme:
    // accentTextTheme:
    // appBarTheme:
    // bottomAppBarTheme:
    buttonTheme: new ButtonThemeData(
        buttonColor: ColorsConfig.primaryDarkColor,
        textTheme: ButtonTextTheme.primary,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15)),
    elevatedButtonTheme: new ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled))
              return ColorsConfig.grey.withOpacity(0.7);
            return ColorsConfig.lightColor; // Use the component's default.
          },
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled))
              return ColorsConfig.grey.withOpacity(0.3);
            return ColorsConfig.primaryColor;
          },
        ),
        overlayColor: MaterialStateProperty.all<Color>(ColorsConfig.accentColor.withOpacity(0.5)),
        //shadowColor: MaterialStateProperty.all<Color>(ColorsConfig.greyLight.withOpacity(0.1)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        padding: kIsWeb
            ? MaterialStateProperty.all(EdgeInsets.all(18))
            : MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12, horizontal: 24)),
      ),
    ),
    textButtonTheme: new TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(ColorsConfig.lightColor),
        overlayColor: MaterialStateProperty.all<Color>(ColorsConfig.accentColor.withOpacity(0.2)),
        padding: kIsWeb ? MaterialStateProperty.all(EdgeInsets.all(18)) : null,
      ),
    ),
    outlinedButtonTheme: new OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(ColorsConfig.primaryColor),
        overlayColor: MaterialStateProperty.all<Color>(ColorsConfig.accentColor.withOpacity(0.2)),
        padding: kIsWeb
            ? MaterialStateProperty.all(EdgeInsets.all(18))
            : MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12, horizontal: 24)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
      ),
    ),
    // cardTheme: CardTheme(
    //   elevation: 5,
    //   color: Colors.indigo,
    // ),
    // chipTheme:
    // dialogTheme:
    // floatingActionButtonTheme:
    // iconTheme: IconThemeData(color: ColorsConfig.primaryColor,),
    // inputDecorationTheme:
    // pageTransitionsTheme:
    // primaryIconTheme:
    //primaryTextTheme:
    // sliderTheme:
    primaryColor: ColorsConfig.primaryColor,
    primaryColorDark: ColorsConfig.primaryDarkColor,
    accentColor: ColorsConfig.accentColor,
    // fontFamily: 'Montserrat',
    buttonColor: ColorsConfig.primaryDarkColor,
    cardColor: ColorsConfig.lightColor,
    primaryColorLight: ColorsConfig.lightColor,
    backgroundColor: ColorsConfig.backgroundColor,
    dialogBackgroundColor: ColorsConfig.backgroundColor,
    scaffoldBackgroundColor: ColorsConfig.backgroundColor,

    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: ColorsConfig.lightColor),
      actionsIconTheme: IconThemeData(color: ColorsConfig.lightColor),
      textTheme: TextTheme(
        bodyText1: TextStyle(color: ColorsConfig.lightColor, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
