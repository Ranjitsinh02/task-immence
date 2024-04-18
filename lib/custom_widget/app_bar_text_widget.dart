import 'package:flutter/material.dart';
import 'package:practical_task/utils/app_strings.dart';

import '../utils/app_color.dart';

class AppBarTextWidget extends StatelessWidget {
  const AppBarTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.appTitle,
      style: TextStyle(fontSize: 28, color: AppColor.darkBlue, fontWeight: FontWeight.bold),
    );
  }
}