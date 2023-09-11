import 'package:dartz/dartz.dart';
import 'package:mobile/features/auth/domain/entities/success.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class GetAuthenticatedAuthSuccessUseCase
    extends UseCase<AuthSuccessEntity, NoParam> {
  final AuthRepository repository;

  GetAuthenticatedAuthSuccessUseCase(this.repository);

  @override
  Future<Either<Failure, AuthSuccessEntity>> call(NoParam param) async {
    return await repository.getAuthInfo();
  }
}
