import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecases/usecase.dart';
import 'package:mobile/features/auth/domain/entities/success.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase implements UseCase<AuthSuccessEntity, Params> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, AuthSuccessEntity>> call(Params param) async {
    return await repository.login(param.email, param.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  const Params({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [];
}
