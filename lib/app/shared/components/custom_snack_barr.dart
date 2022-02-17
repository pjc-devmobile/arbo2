import 'package:arbo/app/modules/core/app_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils/constants/colors.dart';

showCustomSnackBarrError({required String texto, SnackBarAction? snackBarAction, int duration = 3000}) {
  globalMessangerKey.currentState!.showSnackBar(
    SnackBar(
      duration: Duration(milliseconds: duration),
      content: Text(
        texto,
        style: TextStyle(color: ColorsConfig.lightColor),
      ),
      backgroundColor: ColorsConfig.redDarktColor,
      action: snackBarAction,
    ),
  );
}

showCustomSnackBarrInfo({required String texto, SnackBarAction? snackBarAction, int duration = 3000}) {
  globalMessangerKey.currentState!.showSnackBar(
    SnackBar(
      duration: Duration(milliseconds: duration),
      content: Text(
        texto,
      ),
      backgroundColor: ColorsConfig.accentColor,
      action: snackBarAction,
    ),
  );
}

