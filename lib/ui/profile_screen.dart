import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_task/bloc/profile/profile_controller.dart';
import 'package:practical_task/bloc/profile/profile_event.dart';
import 'package:practical_task/bloc/profile/profile_state.dart';
import 'package:practical_task/custom_widget/progress_bar.dart';
import 'package:practical_task/model/user_model.dart';
import 'package:practical_task/ui/login_screen.dart';

import '../custom_widget/text_row_widget.dart';
import '../utils/app_color.dart';
import '../utils/app_image.dart';
import '../utils/app_strings.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            print("State:::$state");
            if (state is ProfileLogoutState) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false);
            }
          },
          builder: (context, state) {
            if (state is ProfileLoadedState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          backgroundColor: AppColor.lightBlue,
                          minRadius: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Image.asset(
                              AppImage.avtarImage,
                              height: 80,
                              width: 80,
                            ),
                          )),
                      Text(
                        state.userModel.name ?? 'John Doe',
                        style: TextStyle(
                            fontSize: 24,
                            color: AppColor.darkBlue,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  TextRowWidget(
                    labelText: AppStrings.email,
                    widgetText: state.userModel.email ?? "john@example.com",
                  ),
                  TextRowWidget(
                    labelText: AppStrings.phoneNo,
                    widgetText: state.userModel.phoneNumber ?? '+91 8200237575',
                  ),
                  TextRowWidget(
                    labelText: AppStrings.logOut,
                    widgetText: '',
                    logoutIcon: () {
                      BlocProvider.of<ProfileBloc>(context).add(SignOut());
                    },
                  ),
                ],
              );
            }
            return const ProgressBarWidget();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context)
        .add(ProfileLoadEvent(userModel: UserModel()));
  }
}
