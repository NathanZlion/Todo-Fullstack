import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class AuthRegisterEvent extends AuthEvent {
  final String userName;
  final String email;
  final String password;

  AuthRegisterEvent({
    required this.userName,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [userName, email, password];
}

class AuthLogoutEvent extends AuthEvent{
  @override
  List<Object?> get props => [];
}