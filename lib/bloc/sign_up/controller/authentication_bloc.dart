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
        final bool response = await AuthService().signUpUser(
          event.name,
          event.emailId,
          event.phoneNumber,
          event.password,
          event.isRemember,
        );

        if (response == true) {
          emit(AuthenticationSuccessState());
        }
      } catch (e) {
        emit(AuthenticationFailureState(e.toString()));
      }
      emit(const AuthenticationLoadingState(isLoading: false));
    });

  }
}
