import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_task/bloc/user_list/event/user_list_event.dart';
import 'package:practical_task/bloc/user_list/state/user_list_state.dart';
import 'package:practical_task/model/user_model.dart';
import 'package:practical_task/service/auth_service.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final AuthService authService = AuthService();

  UserListBloc() : super(UserListInitialState()) {
    on<UserListEvent>((event, emit) {});

    on<UserListLoadEvent>((event, emit) async {
      List<UserModel> userDataList = [];
      try {
        final response = await authService.fetchUsers();
        for (var element in response) {
          userDataList.add(element);
        }
        emit(UserListSuccessState(userModel: userDataList));

      } catch (e) {
        print("error:::${e.toString()}");
      }
    });
  }
}
