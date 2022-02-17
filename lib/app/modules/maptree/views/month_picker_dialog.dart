import 'package:arbo/app/modules/core/models/meses_util.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';
import 'package:utils/utils/constants/colors.dart';

class MonthPickerDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> months = MesesUtil.MONTHS_NAME;

    return Dialog(
      child: ListView.builder(
        itemCount: months.length,
        itemBuilder: (_, index) {
          return TextButton(
            onPressed: () => Navigator.pop(context, {"name": months[index], "index": index}),
            child: Text(
              months[index],
              style: AppTextTheme.textThemeColorBold(color: ColorsConfig.primaryColor),
            ),
          );
        },
      ),
    );
  }
}
