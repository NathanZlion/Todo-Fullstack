import 'package:mobile/core/network/network_info.dart';
import 'package:mobile/core/error/exceptions.dart';
import 'package:mobile/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:mobile/features/todo/domain/entities/todo.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final NetworkInfo networkInfo;
  final TodoRemoteDataSource todoRemoteDataSource;

  TodoRepositoryImpl({
    required this.networkInfo,
    required this.todoRemoteDataSource,
  });

  @override
  Future<Either<Failure, TodoEntity>> createTodo(
    String? title,
    bool? completed,
  ) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return Left(NetworkFailure());
    }

    try {
      return Right(await todoRemoteDataSource.createTodo(title, completed));
    } on ServerException {
      return Left(ServerFailure());
    } on AuthenticationException {
      return Left(AuthenticationFailure());
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, TodoEntity>> deleteTodo(String id) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return Left(NetworkFailure());
    }

    try {
      return Right(await todoRemoteDataSource.deleteTodo(id));
    } on ServerException {
      return Left(ServerFailure());
    } on AuthenticationException {
      return Left(AuthenticationFailure());
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getAllTodos() async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return Left(NetworkFailure());
    }

    try {
      return Right(await todoRemoteDataSource.getAllTodos());
    } on ServerException {
      return Left(ServerFailure());
    } on AuthenticationException {
      return Left(AuthenticationFailure());
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, TodoEntity>> updateTodo(
    String id,
    String? title,
    bool? completed,
  ) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return Left(NetworkFailure());
    }

    try {
      return Right(await todoRemoteDataSource.updateTodo(id, title, completed));
    } on ServerException {
      return Left(ServerFailure());
    } on AuthenticationException {
      return Left(AuthenticationFailure());
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
