import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class UserListTileWithAvatar extends StatelessWidget {
  const UserListTileWithAvatar({
    super.key,
    required this.avatarText,
    required this.title1,
    required this.title2,
    this.onTap,
  });

  final String avatarText;
  final String title1;
  final String title2;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                backgroundColor: AppColor.lightBlue,
                minRadius: 20,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    avatarText,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.darkBlue),
                  ),
                )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title1,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.black),
                  ),
                  Text(
                    title2,
                    style: TextStyle(fontSize: 12, color: AppColor.lightGray),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 20),
            child: InkWell(
              onTap: onTap,
              child: Icon(
                Icons.adjust_rounded,
                size: 24,
                color: AppColor.darkBlue,
              ),
            ),
          ),
        )
      ],
    );
  }
}
