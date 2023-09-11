import 'package:dartz/dartz.dart';
import 'package:mobile/features/auth/data/models/success_model.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/auth_remote_datasource.dart';
import '../../domain/entities/success.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
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
    } on CacheException {
      return Left(await Future.value(CacheFailure()));
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
      // tries to login to the remote datasource
      // if successfull caches the [AuthSuccessEntity].
      final responce = await remoteDataSource.register(
        userName,
        email,
        password,
      );
      await localDataSource
          .cacheAuthenticatedUser(responce as AuthSuccessModel);
      return Right(responce);
    } on ServerException {
      return Left(await Future.value(ServerFailure()));
    } on AuthenticationException {
      return Left(await Future.value(AuthenticationFailure()));
    } on CacheException {
      return Left(await Future.value(CacheFailure()));
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      return Right(await localDataSource.logout());
    } on Exception {
      return Left(await Future.value(CacheFailure()));
    }
  }

  @override
  Future<Either<Failure, AuthSuccessEntity>> getAuthInfo() async {
    try {
      return Right(await localDataSource.getAuthenticatedUserData());
    } on Exception {
      return Left(await Future.value(AuthenticationFailure()));
    }
  }
}
