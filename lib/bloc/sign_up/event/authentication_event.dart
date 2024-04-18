

import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable{
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SignUpUser extends AuthenticationEvent {
  final String name;
  final String emailId;
  final String phoneNumber;
  final String password;
  final bool isRemember;

  const SignUpUser(this.name, this.emailId, this.phoneNumber, this.password, this.isRemember);

  @override
  List<Object> get props => [emailId, password];
}


