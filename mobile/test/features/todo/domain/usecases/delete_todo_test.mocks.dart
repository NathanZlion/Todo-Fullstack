// Mocks generated by Mockito 5.4.0 from annotations
// in mobile/test/features/todo/domain/usecases/delete_todo_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mobile/core/error/failures.dart' as _i5;
import 'package:mobile/features/todo/domain/entities/todo.dart' as _i6;
import 'package:mobile/features/todo/domain/repositories/todo_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TodoRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTodoRepository extends _i1.Mock implements _i3.TodoRepository {
  MockTodoRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.TodoEntity>> createTodo(
    String? id,
    String? title,
    bool? completed,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #createTodo,
          [
            id,
            title,
            completed,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.TodoEntity>>.value(
            _FakeEither_0<_i5.Failure, _i6.TodoEntity>(
          this,
          Invocation.method(
            #createTodo,
            [
              id,
              title,
              completed,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.TodoEntity>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.TodoEntity>>> getAllTodos() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllTodos,
          [],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i6.TodoEntity>>>.value(
                _FakeEither_0<_i5.Failure, List<_i6.TodoEntity>>(
          this,
          Invocation.method(
            #getAllTodos,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.TodoEntity>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.TodoEntity>> updateTodo(
    String? id,
    String? title,
    bool? completed,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateTodo,
          [
            id,
            title,
            completed,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.TodoEntity>>.value(
            _FakeEither_0<_i5.Failure, _i6.TodoEntity>(
          this,
          Invocation.method(
            #updateTodo,
            [
              id,
              title,
              completed,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.TodoEntity>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.TodoEntity>> deleteTodo(
    String? id,
    String? title,
    bool? completed,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteTodo,
          [
            id,
            title,
            completed,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.TodoEntity>>.value(
            _FakeEither_0<_i5.Failure, _i6.TodoEntity>(
          this,
          Invocation.method(
            #deleteTodo,
            [
              id,
              title,
              completed,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.TodoEntity>>);
}
