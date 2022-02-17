import 'package:arbo/l10n/app_localization.dart';
import 'package:flutter/material.dart';

import '../responsive_values.dart';

class ProgressDialog extends StatefulWidget {
  final title;

  const ProgressDialog({required this.title});

  @override
  _ProgressDialogState createState() => _ProgressDialogState();
}

class _ProgressDialogState extends State<ProgressDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: WillPopScope(
        onWillPop: () => _onWillPop(),
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(
                child: Text(widget.title),
              ),
              SizedBox(
                height: Responsive.to.prefPaddinHeight,
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
              SizedBox(
                height: Responsive.to.prefPaddinHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return false;
  }
}

showProgressDialog(BuildContext context, {String? title}){
  if (title == null) title = S.to.aguarde;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => ProgressDialog(title: title),
  );
}
