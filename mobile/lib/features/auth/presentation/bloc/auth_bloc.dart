import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecases/usecase.dart';
import '../../domain/usecases/login.dart' as login_usecase;
import '../../domain/usecases/register.dart' as register_usecase;
import '../../domain/usecases/logout.dart' as logout_usecase;

import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = "Server Failure";
const String CACHE_FAILURE_MESSAGE = "Cache Failure";
const String AUTHENTICATION_FAILURE_MESSAGE = "Authentication Failure";
const String NETWORK_FAILURE_MESSAGE = "Network Failure";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /* all usecases */
  final login_usecase.LoginUseCase login;
  final register_usecase.RegisterUseCase register;
  final logout_usecase.LogoutUseCase logout;

  AuthBloc({
    required this.login,
    required this.register,
    required this.logout,
  }) : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoading());
      final loginResponse = await login.call(
        login_usecase.Params(email: event.email, password: event.password),
      );

      loginResponse.fold(
        (failure) => emit(AuthError(_getErrorMessageFromFailure(failure))),
        (success) => emit(AuthSuccess(success.user)),
      );
    });

    on<AuthRegisterEvent>((event, emit) async {
      emit(AuthLoading());
      final registerResponse = await register.call(register_usecase.Params(
        userName: event.userName,
        email: event.email,
        password: event.password,
      ));

      registerResponse.fold(
        (failure) => emit(AuthError(_getErrorMessageFromFailure(failure))),
        (success) => emit(AuthSuccess(success.user)),
      );
    });

    on<AuthLogoutEvent>((event, emit) async {
      emit(AuthLoading());
      final logoutResponse = await logout.call(const NoParam());

      logoutResponse.fold(
        (failure) => emit(AuthError(_getErrorMessageFromFailure(failure))),
        (success) => emit(AuthInitial()),
      );
    });
  }

  String _getErrorMessageFromFailure(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case NetworkFailure:
        return NETWORK_FAILURE_MESSAGE;
      default:
        return AUTHENTICATION_FAILURE_MESSAGE;
    }
  }
}
