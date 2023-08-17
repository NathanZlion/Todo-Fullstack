import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile/features/todo/domain/entities/todo.dart';
import 'package:mobile/features/todo/domain/repositories/todo_repository.dart';
import '../../../../core/usecases/usecase.dart';

class CreateTodo implements UseCase<TodoEntity, Param> {
  final TodoRepository repository;

  CreateTodo(this.repository);

  @override
  Future<Either<Failure, TodoEntity>> call(param) async {
    return await repository.createTodo(param.id, param.title, param.completed);
  }
}

class Param extends Equatable {
  final String title;
  final bool completed;
  final String id;

  const Param({required this.title, required this.completed, required this.id});

  @override
  List<Object?> get props => [title, completed, id];
}
