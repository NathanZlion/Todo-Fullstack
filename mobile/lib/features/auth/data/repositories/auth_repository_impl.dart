import 'package:mobile/core/Network/network_info.dart';
import 'package:mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mobile/features/auth/domain/entities/success.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile/features/auth/domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, AuthSuccessEntity>> login(
    String? email,
    String? password,
  ) async {
    networkInfo.isConnected;

    try {
      return Right(await remoteDataSource.login(email, password));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AuthSuccessEntity>> register(
    String? userName,
    String? email,
    String? password,
  ) async {
    throw UnimplementedError();
  }
}
