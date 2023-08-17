import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failures.dart';

import '../entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, TodoEntity>> createTodo(TodoEntity todo);
  Future<Either<Failure, List<TodoEntity>>> getAllTodos();
  Future<Either<Failure, TodoEntity>> updateTodo(TodoEntity todo);
  Future<Either<Failure, TodoEntity>> deleteTodo(TodoEntity todo);
}
