import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUser extends LoginEvent {
  final String emailId;
  final String password;
  final bool isRemember;

  const LoginUser(this.emailId, this.password, this.isRemember);

  @override
  List<Object> get props => [emailId, password, isRemember];
}
