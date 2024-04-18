import 'package:equatable/equatable.dart';

import '../../../model/user_model.dart';

abstract class UserListState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserListInitialState extends UserListState {}

class UserListLoadingState extends UserListState {
  final bool isLoading;

  UserListLoadingState({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

class UserListSuccessState extends UserListState {
  final List<UserModel> userModel;

  UserListSuccessState({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

class UserListFailureState extends UserListState {
  final String errorMessage;

  UserListFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
