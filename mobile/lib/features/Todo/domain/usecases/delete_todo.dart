import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';

import 'package:dartz/dartz.dart';
import 'package:mobile/features/todo/domain/entities/todo.dart';
import 'package:mobile/features/todo/domain/repositories/todo_repository.dart';

import '../../../../core/usecases/usecase.dart';

class DeleteTodo implements UseCase<TodoEntity, Param> {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  @override
  Future<Either<Failure, TodoEntity>> call(param) async {
    return await repository.deleteTodo(param.id);
  }
}

class Param extends Equatable {
  final String id;

  const Param({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
