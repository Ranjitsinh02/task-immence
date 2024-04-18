import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_task/bloc/login/event/login_event.dart';
import 'package:practical_task/bloc/login/state/login_state.dart';
import 'package:practical_task/ui/bottom_navigation.dart';

import '../../../service/auth_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService = AuthService();

  LoginBloc() : super(LoginInitialState()) {
    on<LoginEvent>((event, emit) {});

    on<LoginUser>((event, emit) async {
      emit(const LoginLoadingState(isLoading: true));
      try {
        final bool userModel =
            await authService.loginUser(event.emailId, event.password);

        print("UserModel:::${userModel}");
        if (userModel == true) {
          emit(LoginSuccessState(isUserAvailable: userModel));
        }
      } catch (e) {
        emit(LoginFailureState(errorMessage: e.toString()));
      }
      emit(const LoginLoadingState(isLoading: false));
    });
  }
}
