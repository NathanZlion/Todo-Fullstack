import 'package:mobile/core/error/exceptions.dart';
import 'package:mobile/features/todo/domain/entities/todo.dart';

abstract class TodoRemoteDataSource {
  /// Tries to create a new todo from the remtote api
  /// If there is an error it throws exceptions
  /// [AuthenticationException] [ServerException] [NetworkException]
  Future<TodoEntity> createTodo(String? title, bool? completed);

  /// Tries to get all todos from the remtote api
  /// It takes no parameters.
  /// If there is an error it throws exceptions
  /// [AuthenticationException] [ServerException] [NetworkException]
  Future<List<TodoEntity>> getAllTodos();

  /// Tries to update a todo from the remtote api
  /// If there is an error it throws exceptions
  /// [AuthenticationException] [ServerException] [NetworkException]
  Future<TodoEntity> updateTodo(String id, String? title, bool? completed);

  /// Tries to delete a todo from the remtote api
  /// If there is an error it throws exceptions
  /// [AuthenticationException] [ServerException] [NetworkException]
  Future<TodoEntity> deleteTodo(String id);
}
