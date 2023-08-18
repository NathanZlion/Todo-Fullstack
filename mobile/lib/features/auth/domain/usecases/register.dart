import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecases/usecase.dart';
import 'package:mobile/features/auth/domain/entities/sucess.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase implements UseCase<AuthSuccessEntity, Params> {
  AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, AuthSuccessEntity>> call(Params param) async {
    return await repository.register(
        param.userName, param.email, param.password);
  }
}

class Params extends Equatable {
  final String userName;
  final String email;
  final String password;

  const Params(
      {required this.userName, required this.email, required this.password});
  @override
  List<Object?> get props => [userName, email, password];
}
