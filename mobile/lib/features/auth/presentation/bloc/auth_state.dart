// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile/features/auth/domain/entities/user.dart';

abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSuccess extends AuthState {
  UserEntity user;

  AuthSuccess(this.user);
  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
  @override
  List<Object?> get props => [message];
}
