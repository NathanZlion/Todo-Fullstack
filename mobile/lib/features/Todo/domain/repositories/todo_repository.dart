import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<TodoEntity>>> getAllTodos();

  Future<Either<Failure, TodoEntity>> createTodo(
    String title,
    bool? completed,
  );

  Future<Either<Failure, TodoEntity>> updateTodo(
    String id,
    String? title,
    bool? completed,
  );

  Future<Either<Failure, TodoEntity>> deleteTodo(String id);
}
