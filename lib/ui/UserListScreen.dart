import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_task/bloc/user_list/state/user_list_state.dart';

import '../bloc/user_list/controller/UserListController.dart';
import '../custom_widget/app_bar_text_widget.dart';
import '../custom_widget/progress_bar.dart';
import '../custom_widget/user_list_tile.dart';
import '../utils/app_strings.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTextWidget(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(top: 40, left: 18, right: 18),
              child: const Text(
                AppStrings.users,
                style: TextStyle(fontSize: 24),
              )),
          BlocConsumer<UserListBloc, UserListState>(
            builder: (context, state) {
              if (state is UserListSuccessState) {
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                          shape: const RoundedRectangleBorder(),
                          shadowColor: Colors.grey,
                          surfaceTintColor: Colors.white,
                          elevation: 1,
                          child: Container(
                              margin: const EdgeInsets.only(left: 10, top: 5),
                              child: UserListTileWithAvatar(
                                avatarText:
                                    state.userModel[index].name.toString()[0].toUpperCase(),
                                title1: state.userModel[index].name.toString(),
                                title2: state.userModel[index].email.toString(),
                              )));
                    },
                    itemCount: state.userModel.length,
                  ),
                );
              } else if (state is UserListFailureState) {
                return const Text('Some thing wrong!');
              } else if (state is UserListLoadingState) {
                return const ProgressBarWidget();
              } else {
                return const Center(child: ProgressBarWidget());
              }
            },
            listener: (BuildContext context, UserListState state) {
              if (state is UserListSuccessState) {}
            },
          ),
        ],
      ),
    );
  }
}
