import 'package:equatable/equatable.dart';

import '../../model/user_model.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {
  final bool isLoading;

  ProfileLoadingState({required this.isLoading});

  @override
  List<Object> get props => [];
}

class ProfileLoadedState extends ProfileState {
  final UserModel userModel;

  ProfileLoadedState({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

class ProfileFailureState extends ProfileState {
  final String errorMessage;

  ProfileFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class ProfileLogoutState extends ProfileState{

}
