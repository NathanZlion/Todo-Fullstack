import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/todo/domain/entities/todo.dart';
import 'package:mobile/features/todo/domain/repositories/todo_repository.dart';
import 'package:mobile/features/todo/domain/usecases/delete_todo.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'delete_todo_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late MockTodoRepository mockTodoRepository;
  late TodoEntity tTodoEntity;
  late DeleteTodo useCase;

  const String tTitle = "test title";
  const bool tCompleted = false;
  const String tId = "623ads971329102938df";

  setUp(() {
    // this is a setup for todo creation usecase
    mockTodoRepository = MockTodoRepository();
    tTodoEntity =
        const TodoEntity(title: tTitle, completed: tCompleted, id: tId);
    useCase = DeleteTodo(mockTodoRepository);
  });

  test("Delete Todo Should call the Todo repository Delete", () async {
    // arrange
    when(mockTodoRepository.deleteTodo(any, any, any))
        .thenAnswer((_) async => Right(tTodoEntity));

    // act
    var result = await useCase(
        const Param(title: tTitle, completed: tCompleted, id: tId));

    // assert
    expect(result, Right(tTodoEntity));
    verify(mockTodoRepository.deleteTodo(tId, tTitle, tCompleted));
    verifyNoMoreInteractions(mockTodoRepository);
  });
}
