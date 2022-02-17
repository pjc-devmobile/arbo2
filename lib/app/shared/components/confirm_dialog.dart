import 'package:arbo/app/shared/responsive_values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils/constants/colors.dart';

class ConfirmDialog extends StatefulWidget {
  final String title;
  final String? info;
  final Widget? icon;
  final String buttonCancelar;
  final String buttonConfirmar;

  const ConfirmDialog({
    required this.title,
    this.info,
    this.icon,
    required this.buttonCancelar,
    required this.buttonConfirmar,
  });

  @override
  _ConfirmDialogState createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: Responsive.to.oneUnitValueHeightScreen*4,
        width: Responsive.to.oneUnitValueWidthScreen*5,
        padding: Responsive.to.prefPaddingSymmetric,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: Responsive.to.prefPaddinHeight,
            ),
            Center(
              child: Text(
                widget.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            SizedBox(
              height: Responsive.to.prefPaddinHeight,
            ),
            if (widget.info != null) Text(widget.info!),
            Spacer(),
            if(widget.icon!=null) Padding(
              padding: Responsive.to.prefPaddingSymmetric,
              child: Center(child: widget.icon),
            ),
            Spacer(),
            buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            widget.buttonCancelar,
            style: TextStyle(color: ColorsConfig.primaryColor),
          ),
        ),
        SizedBox(width: Responsive.to.prefPaddinWidth,),
        ElevatedButton(
          onPressed: ()=> Navigator.pop(context, true),
          child: Text(
            widget.buttonConfirmar,
          ),
        ),
      ],
    );
  }
}
