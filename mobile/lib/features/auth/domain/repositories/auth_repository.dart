import 'package:dartz/dartz.dart';
import 'package:mobile/features/auth/domain/entities/login.dart';

import '../../../../core/error/failures.dart';

abstract class AuthRepository {
  // 2 methods on auth repository which try to do the task

  Future<Either<Failure, LoginEntity>> login(String? email, String? password);
  Future<Either<Failure, LoginEntity>> regester(String? userName, String? email, String? password);
}
