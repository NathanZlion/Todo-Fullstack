import 'package:mobile/core/Network/network_info.dart';
import 'package:mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mobile/features/auth/domain/entities/success.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
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
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return Left(NetworkFailure());
    }

    try {
      return Right(await remoteDataSource.login(email, password));
    } on ServerException {
      return Left(await Future.value(ServerFailure()));
    } on AuthenticationException {
      return Left(await Future.value(AuthenticationFailure()));
    } on Exception {
      // point finger at the server by default 😆
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AuthSuccessEntity>> register(
    String? userName,
    String? email,
    String? password,
  ) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return Left(NetworkFailure());
    }

    try {
      return Right(await remoteDataSource.register(userName, email, password));
    } on ServerException {
      return Left(await Future.value(ServerFailure()));
    } on AuthenticationException {
      return Left(await Future.value(AuthenticationFailure()));
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
