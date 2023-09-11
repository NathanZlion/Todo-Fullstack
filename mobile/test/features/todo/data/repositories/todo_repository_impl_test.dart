import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/network/network_info.dart';
import 'package:mobile/core/error/exceptions.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:mobile/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:mobile/features/todo/domain/entities/todo.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'todo_repository_impl_test.mocks.dart';

@GenerateMocks([NetworkInfo])
@GenerateNiceMocks([MockSpec<TodoRemoteDataSource>()])
void main() {
  late TodoRepositoryImpl repository;
  late MockTodoRemoteDataSource mockTodoRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockTodoRemoteDataSource = MockTodoRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TodoRepositoryImpl(
        networkInfo: mockNetworkInfo,
        todoRemoteDataSource: mockTodoRemoteDataSource);
  });

  const String tTitle = "test title";
  const bool tCompleted = false;
  const String tId = "some test id";
  const tExceptionMessage = "test Exception message";
  const tTodo = TodoEntity(title: tTitle, completed: tCompleted, id: tId);
  group("Get All Todos", () {
    test("Should check for internet connection when get all todos is called.",
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      await repository.getAllTodos();
      verify(mockNetworkInfo.isConnected).called(1);
    });

    group("Device is Offline", () {
      test("Should return a network failure when there is no connection",
          () async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        var result = await repository.getAllTodos();

        expect(result, Left(NetworkFailure()));
        verifyZeroInteractions(mockTodoRemoteDataSource);
      });
    });

    group("Device is Online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      const tTodoList = [TodoEntity(title: "", completed: false, id: '')];
      test(
          "Should return a Server Failure when a server exception is thrown by the datasource",
          () async {
        when(mockTodoRemoteDataSource.getAllTodos())
            .thenThrow(ServerException(tExceptionMessage));

        var result = await repository.getAllTodos();
        expect(result, Left(ServerFailure()));
      });

      test(
          "Should return an Authentication Failure when an Authentication Exception occurs",
          () async {
        when(mockTodoRemoteDataSource.getAllTodos())
            .thenThrow(const AuthenticationException(tExceptionMessage));

        var result = await repository.getAllTodos();
        expect(result, Left(AuthenticationFailure()));
      });

      test(
          "Should return a list of todos when the call to the remote datasource is succesfull",
          () async {
        when(mockTodoRemoteDataSource.getAllTodos())
            .thenAnswer((_) async => tTodoList);

        var result = await repository.getAllTodos();
        expect(result, const Right(tTodoList));
      });
    });
  });

  group("Create todo", () {
    test("Should check for internet connection when Create todo is called.",
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      await repository.createTodo(tTitle, tCompleted);
      verify(mockNetworkInfo.isConnected).called(1);
    });

    group("Device is Offline", () {
      test("Should return a network failure when there is no connection",
          () async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        var result = await repository.createTodo(tTitle, tCompleted);

        expect(result, Left(NetworkFailure()));
        verifyZeroInteractions(mockTodoRemoteDataSource);
      });
    });

    group("Device is Online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          "Should return a Server Failure when a server exception is thrown by the datasource",
          () async {
        when(mockTodoRemoteDataSource.createTodo(any, any))
            .thenThrow(ServerException(tExceptionMessage));

        var result = await repository.createTodo(tTitle, tCompleted);
        expect(result, Left(ServerFailure()));
      });

      test(
          "Should return an Authentication Failure when an Authentication Exception occurs",
          () async {
        when(mockTodoRemoteDataSource.createTodo(any, any))
            .thenThrow(const AuthenticationException(tExceptionMessage));

        var result = await repository.createTodo(tTitle, tCompleted);
        expect(result, Left(AuthenticationFailure()));
      });

      test(
          "Should return a todos when the call to the remote datasource is succesfull",
          () async {
        when(mockTodoRemoteDataSource.createTodo(any, any))
            .thenAnswer((_) async => tTodo);

        var result = await repository.createTodo(tTitle, tCompleted);
        expect(result, const Right(tTodo));
      });
    });
  });

  group("Delete todo", () {
    test("Should check for internet connection when delete todo is called.",
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      await repository.deleteTodo(tId);
      verify(mockNetworkInfo.isConnected).called(1);
    });

    group("Device is Offline", () {
      test("Should return a network failure when there is no connection",
          () async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        var result = await repository.deleteTodo(tId);

        expect(result, Left(NetworkFailure()));
        verifyZeroInteractions(mockTodoRemoteDataSource);
      });
    });

    group("Device is Online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          "Should return a Server Failure when a server exception is thrown by the datasource",
          () async {
        when(mockTodoRemoteDataSource.deleteTodo(any))
            .thenThrow(ServerException(tExceptionMessage));

        var result = await repository.deleteTodo(tId);
        expect(result, Left(ServerFailure()));
      });

      test(
          "Should return an Authentication Failure when an Authentication Exception occurs",
          () async {
        when(mockTodoRemoteDataSource.deleteTodo(any))
            .thenThrow(const AuthenticationException(tExceptionMessage));

        var result = await repository.deleteTodo(tId);
        expect(result, Left(AuthenticationFailure()));
      });

      test(
          "Should return a todos when the call to the remote datasource is succesfull",
          () async {
        when(mockTodoRemoteDataSource.deleteTodo(any))
            .thenAnswer((_) async => tTodo);

        var result = await repository.deleteTodo(tId);
        expect(result, const Right(tTodo));
      });
    });
  });

  group("Update todo", () {
    test("Should check for internet connection when update todo is called.",
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      await repository.updateTodo(tId, tTitle, tCompleted);
      verify(mockNetworkInfo.isConnected).called(1);
    });

    group("Device is Offline", () {
      test("Should return a network failure when there is no connection",
          () async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        var result = await repository.updateTodo(tId, tTitle, tCompleted);

        expect(result, Left(NetworkFailure()));
        verifyZeroInteractions(mockTodoRemoteDataSource);
      });
    });

    group("Device is Online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          "Should return a Server Failure when a server exception is thrown by the datasource",
          () async {
        when(mockTodoRemoteDataSource.updateTodo(any, any, any))
            .thenThrow(ServerException(tExceptionMessage));

        var result = await repository.updateTodo(tId, tTitle, tCompleted);
        expect(result, Left(ServerFailure()));
      });

      test(
          "Should return an Authentication Failure when an Authentication Exception occurs",
          () async {
        when(mockTodoRemoteDataSource.updateTodo(any, any, any))
            .thenThrow(const AuthenticationException(tExceptionMessage));

        var result = await repository.updateTodo(tId, tTitle, tCompleted);
        expect(result, Left(AuthenticationFailure()));
      });

      test(
          "Should return a todo when the call to the remote datasource is succesfull",
          () async {
        when(mockTodoRemoteDataSource.updateTodo(any, any, any))
            .thenAnswer((_) async => tTodo);

        var result = await repository.updateTodo(tId, tTitle, tCompleted);
        expect(result, const Right(tTodo));
      });
    });
  });
}
