import 'package:equatable/equatable.dart';

import '../../model/user_model.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class ProfileLoadEvent extends ProfileEvent{
  final UserModel userModel;

  ProfileLoadEvent({required this.userModel});
  @override
  List<Object> get props => [userModel];
}

class SignOut extends ProfileEvent {}