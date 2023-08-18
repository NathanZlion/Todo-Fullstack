import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/todo/domain/entities/todo.dart';
import 'package:mobile/features/todo/domain/repositories/todo_repository.dart';
import 'package:mobile/features/todo/domain/usecases/get_all_todos.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_todos_test.mocks.dart';


@GenerateMocks([TodoRepository])
void main() {
  late MockTodoRepository mockTodoRepository;
  late List<TodoEntity> tTodoEntities;
  late GetTodos useCase;

  const String tTitle = "test title";
  const bool tCompleted = false;
  const String tId = "623ads971329102938df";

  setUp(() {
    // this is a setup for todo creation usecase
    mockTodoRepository = MockTodoRepository();
    tTodoEntities = [
      const TodoEntity(title: tTitle, completed: tCompleted, id: tId)
    ];
    useCase = GetTodos(mockTodoRepository);
  });

  test("Update Todo Should call the Todo repository Update todo", () async {
    // arrange
    when(mockTodoRepository.getAllTodos()).thenAnswer((_) async => Right(tTodoEntities));

    // act
    var result = await useCase(const NoParam());

    // assert
    expect(result, Right(tTodoEntities));
    verify(mockTodoRepository.getAllTodos()).called(1);
    verifyNoMoreInteractions(mockTodoRepository);
  });
}
