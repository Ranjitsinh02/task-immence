import 'package:equatable/equatable.dart';

import '../../../model/user_model.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {
  final bool isLoading;

  const LoginLoadingState({required this.isLoading});
}

class LoginSuccessState extends LoginState {
  final bool isUserAvailable;

  const LoginSuccessState({required this.isUserAvailable});

  @override
  List<Object> get props => [isUserAvailable];
}

class LoginFailureState extends LoginState {
  final String errorMessage;

  const LoginFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
