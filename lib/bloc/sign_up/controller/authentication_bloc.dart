import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_task/service/auth_service.dart';

import '../../../model/user_model.dart';
import '../event/authentication_event.dart';
import '../state/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService authService = AuthService();

  AuthenticationBloc() : super(AuthenticationInitialState()) {
    on<AuthenticationEvent>(
      (event, emit) {},
    );

    on<SignUpUser>((event, emit) async {
      emit(const AuthenticationLoadingState(isLoading: true));
      try {
        final UserModel? userModel = await AuthService().signUpUser(
          event.name,
          event.emailId,
          event.phoneNumber,
          event.password,
          event.isRemember,
        );

        if (userModel != null) {
          emit(AuthenticationSuccessState(userModel));
        } else {
          emit(const AuthenticationFailureState('Create user failed'));
        }
      } catch (e) {
        emit(AuthenticationFailureState(e.toString()));
      }
      emit(const AuthenticationLoadingState(isLoading: false));
    });

  }
}
