
import 'package:equatable/equatable.dart';

import '../../../model/user_model.dart';

abstract class UserListEvent extends Equatable{

  @override
  List<Object> get props => [];
}

class UserListLoadEvent extends UserListEvent{
  final List<UserModel> userModel;

  UserListLoadEvent({required this.userModel});

  @override
  List<Object> get props => [userModel];
}