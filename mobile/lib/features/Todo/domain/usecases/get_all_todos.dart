import 'package:mobile/core/error/failures.dart';

import 'package:dartz/dartz.dart';
import 'package:mobile/features/todo/domain/entities/todo.dart';
import 'package:mobile/features/todo/domain/repositories/todo_repository.dart';

import '../../../../core/usecases/usecase.dart';

class GetTodos implements UseCase<List<TodoEntity>, NoParam> {
  final TodoRepository repository;

  GetTodos(this.repository);

  @override
  Future<Either<Failure, List<TodoEntity>>> call(param) async {
    return await repository.getAllTodos();
  }
}

