import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failures.dart';

import '../entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, TodoEntity>> createTodo(String? id, String? title, bool? completed);
  Future<Either<Failure, List<TodoEntity>>> getAllTodos();
  Future<Either<Failure, TodoEntity>> updateTodo();
  Future<Either<Failure, TodoEntity>> deleteTodo();
}
