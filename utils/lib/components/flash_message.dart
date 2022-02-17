import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils/constants/colors.dart';

class FlashMessage {
  static showFlashMessage({
    required BuildContext context,
    required int duration,
    required Color backGroundColor,
    required Icon icon,
    required Widget message,
  }) {
    showFlash(
        context: context,
        duration: Duration(milliseconds: duration),
        builder: (context, controller) {
          return Center(
            child: Flash(
              // borderRadius: BorderRadius.circular(PADDING_BASE/2),
              backgroundColor: backGroundColor,
              controller: controller,
              style: FlashStyle.floating,
              position: FlashPosition.top,
              margin: EdgeInsets.symmetric(vertical: 16),
              horizontalDismissDirection: HorizontalDismissDirection.horizontal,
              child: FlashBar(
                icon: icon,
                message: Center(
                  child: message,
                ),
              ),
            ),
          );
        });
  }

  static showMessageErro({
    required BuildContext context,
    required Widget message,
    int duration = 4000,
  }) {
    showFlashMessage(
        context: context,
        duration: duration,
        backGroundColor: ColorsConfig.redDarktColor,
        icon: Icon(
          Icons.error,
          color: ColorsConfig.lightColor,
        ),
        message: message);
  }

  static showMessageSucces({
    required BuildContext context,
    required Widget message,
    int duration = 4000,
  }) {
    showFlashMessage(
        context: context,
        duration: duration,
        backGroundColor: ColorsConfig.greenDarkColor,
        icon: Icon(
          Icons.check_circle_outline,
          color: ColorsConfig.lightColor,
        ),
        message: message);
  }

  static showMessageAlert({
    required BuildContext context,
    required Widget message,
    int duration = 3000,
  }) {
    showFlashMessage(
        context: context,
        duration: duration,
        backGroundColor: ColorsConfig.blueColor,
        icon: Icon(
          Icons.info_outline,
          color: ColorsConfig.lightColor,
        ),
        message: message);
  }
}
