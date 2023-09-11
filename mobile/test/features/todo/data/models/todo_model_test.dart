import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/todo/domain/entities/todo.dart';
import 'package:mobile/features/todo/data/models/todo_model.dart';

import '../../../../helper/json_reader.dart';

void main() {
  const tTodoModel = TodoModel(
      id: "64dc9008872355b87f08627f", title: "test to do.", completed: false);

  test("Should be a subclass of the todo entity", () {
    // assert
    expect(tTodoModel, isA<TodoEntity>());
  });

  test("Should return a valid todo model when a valid json is given to it.",
      () {
    // arrange
    final Map<String, dynamic> tJson = jsonDecode(jsonReader('todo.json'));

    // act
    final result = TodoModel.fromJson(tJson);
    // assert
    expect(result, tTodoModel);
  });

  test("Should return a valid json when tojson is called on the todo", () {
    // arrange
    final Map<String, dynamic> json = tTodoModel.toJson();
    final expected = {
      '_id': '64dc9008872355b87f08627f',
      'title': 'test to do.',
      'completed': false,
    };

    // expect
    expect(
      json,
      expected,
    );
  });
}
