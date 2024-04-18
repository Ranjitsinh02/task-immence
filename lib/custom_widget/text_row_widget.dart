import 'package:flutter/material.dart';
import 'package:practical_task/utils/app_color.dart';

class TextRowWidget extends StatelessWidget {
  const TextRowWidget({
    super.key,
    required this.labelText,
    required this.widgetText,
    this.logoutIcon,
  });

  final String labelText;
  final String widgetText;
  final GestureTapCallback? logoutIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  labelText,
                  style: TextStyle(color: AppColor.black, fontSize: 18),
                ),
                widgetText != ''
                    ? Text(
                        widgetText,
                        style: TextStyle(
                          color: AppColor.darkBlue,
                        ),
                      )
                    : InkWell(
                        onTap: logoutIcon,
                        child: Icon(
                          Icons.logout_outlined,
                          color: AppColor.darkBlue,
                        ))
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
