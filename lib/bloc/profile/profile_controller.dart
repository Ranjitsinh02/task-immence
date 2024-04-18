import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_task/bloc/profile/profile_event.dart';
import 'package:practical_task/bloc/profile/profile_state.dart';
import 'package:practical_task/service/auth_service.dart';

import '../../service/sharepreference_service.dart';
import '../../utils/app_strings.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  AuthService authService = AuthService();

  ProfileBloc() : super(ProfileInitialState()) {
    on<ProfileEvent>((event, emit) {});

    on<ProfileLoadEvent>((event, emit) async {
      final userId = SharedPreferencesService.getData(AppStrings.userId);
      try {
        final response = await authService.fetchUsers();

        for (int i = 0; i < response.length; i++) {
          if (userId == response[i].id.toString()) {
            print("ResponseIIIDDDD::::${response[i].id.toString()}");
            emit(ProfileLoadedState(userModel: response[i]));
          }
        }

      } catch (e) {
        print(e);
        emit(ProfileFailureState(errorMessage: e.toString()));
      }
    });

    on<SignOut>((event, emit) async {
      try {
        await authService.signOutUser();
        emit(ProfileLogoutState());
      } catch (e) {
        emit(ProfileFailureState(errorMessage: e.toString()));
      }
    });
  }
}
