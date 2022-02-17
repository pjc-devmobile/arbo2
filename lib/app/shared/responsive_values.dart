import 'package:arbo/app/modules/core/app_widget.dart';
import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  final double height;
  final double width;
  final double heightWithoutPaddind;
  final double widthWithoutPaddind;
  final bool isPortrair;

  static Responsive get to => Responsive(globalMessangerKey.currentState!.context);

  Responsive(this.context)
      : height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
        width = MediaQuery.of(context).size.width,
        heightWithoutPaddind = MediaQuery.of(context).size.height,
        widthWithoutPaddind = MediaQuery.of(context).size.width,
        isPortrair = MediaQuery.of(context).orientation == Orientation.portrait;

  ///10% do tamanho da tela no eixo x.
  double get oneUnitValueWidthScreen {
    return width * .1;
  }

  ///10% do tamanho da tela no eixo y.
  double get oneUnitValueHeightScreen {
    return height * .1;
  }

  EdgeInsets get minPaddingSymmetricVertical {
    return EdgeInsets.symmetric(
      vertical: prefPaddinHeight/2,
    );
  }

  EdgeInsets get minPaddingSymmetricHorizontal {
    return EdgeInsets.symmetric(
      horizontal: prefPaddinWidth/2,
    );
  }

  EdgeInsets get minPaddingSymmetric {
    return EdgeInsets.symmetric(
      vertical: prefPaddinHeight/2,
      horizontal: prefPaddinWidth/2,
    );
  }

  EdgeInsets get prefPaddingSymmetricVertical {
    return EdgeInsets.symmetric(
      vertical: prefPaddinHeight,
    );
  }

  EdgeInsets get prefPaddingHorizontal {
    return EdgeInsets.symmetric(
      horizontal: prefPaddinWidth,
      vertical: 0,
    );
  }

  double get prefPaddinHeight => 16;

  double get prefPaddinWidth => isPortrair
      ? 16
      : 32;

  EdgeInsets get maxPaddingSymmetricVertical {
    return EdgeInsets.symmetric(
      vertical: prefPaddinHeight*2,
    );
  }

  EdgeInsets get prefPaddingSymmetric {
    return EdgeInsets.symmetric(
      horizontal: prefPaddinWidth,
      vertical: prefPaddinHeight,
    );
  }

  EdgeInsets get paddingMaxSymmetric {
    return EdgeInsets.symmetric(
      horizontal: prefPaddinWidth*2,
      vertical: prefPaddinHeight*2,
    );
  }

  EdgeInsets get prefPaddingSymmetricMax {
    return EdgeInsets.symmetric(
      horizontal: prefPaddinWidth*2,
      vertical: prefPaddinHeight*2,
    );
  }

  EdgeInsets get maxPaddingSymmetricOnlyHorizontal {
    return EdgeInsets.symmetric(
      horizontal: prefPaddinWidth*2,
    );
  }

  ///Buttons
  double get buttonExtraLargeHeight => 60;
  double get buttonLargeHeight => 50;
  double get buttonMediumHeight => 40;
  double get buttonMinimumHeight => 30;
  double get buttonTextHeight => 35;

  ///Cabeçalhos
  double get header => 100;
  double get headerMax => 200;//.2697;
}
