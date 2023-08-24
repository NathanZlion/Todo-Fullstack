import 'package:dartz/dartz.dart';
import 'package:mobile/features/auth/domain/entities/success.dart';

import '../../../../core/error/failures.dart';

abstract class AuthRepository {
  // 2 methods on auth repository which try to do the task

  Future<Either<Failure, AuthSuccessEntity>> login(String? email, String? password);
  Future<Either<Failure, AuthSuccessEntity>> register(String? userName, String? email, String? password);
}
