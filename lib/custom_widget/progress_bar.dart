import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      color: AppColor.darkBlue,
    ));
  }
}
