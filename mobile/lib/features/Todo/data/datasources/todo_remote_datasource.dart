import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/todo.dart';

abstract class TodoRemoteDataSource {
  /// Tries to create a new todo from the remtote api
  /// If there is an error it throws exceptions
  /// [AuthenticationException] [ServerException]
  Future<TodoEntity> createTodo(String? title, bool? completed);

  /// Tries to get all todos from the remtote api
  /// It takes no parameters.
  /// If there is an error it throws exceptions
  /// [AuthenticationException] [ServerException]
  Future<List<TodoEntity>> getAllTodos();

  /// Tries to update a todo from the remtote api
  /// If there is an error it throws exceptions
  /// [AuthenticationException] [ServerException]
  Future<TodoEntity> updateTodo(String id, String? title, bool? completed);

  /// Tries to delete a todo from the remtote api
  /// If there is an error it throws exceptions
  /// [AuthenticationException] [ServerException]
  Future<TodoEntity> deleteTodo(String id);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final http.Client client;

  TodoRemoteDataSourceImpl({required this.client});

  @override
  Future<TodoEntity> createTodo(String? title, bool? completed) async {
    final http.Response response = await client.post(
      Uri.https('localhost:5000', 'api/todo'),
      headers: {'Content-Type': 'application/json'},
      body: {'title': title},
    );

    final resbody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return TodoEntity(
        title: title!,
        completed: completed!,
        id: resbody["todo"]['_id'],
      );
    } else if (response.statusCode == 400) {
      throw AuthenticationException(resbody["message"]);
    } else {
      throw ServerException(resbody["message"]);
    }
  }

  @override
  Future<TodoEntity> deleteTodo(String id) async {
    final http.Response response = await client.patch(
      Uri.https('localhost:5000', 'api/todo/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    final resbody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return TodoEntity(
        title: resbody["todo"]['title'],
        completed: resbody["todo"]['completed'],
        id: resbody["todo"]['_id'],
      );
    } else if (response.statusCode == 400) {
      throw AuthenticationException(resbody["message"]);
    } else {
      throw ServerException(resbody["message"]);
    }
  }

  @override
  Future<List<TodoEntity>> getAllTodos() async {
    final http.Response response = await client.get(
      Uri.https('localhost:5000', 'api/todo/'),
      headers: {'Content-Type': 'application/json'},
    );

    final resbody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List<Map> todos = resbody["todos"];
      return todos
          .map(
            (todo) => TodoEntity(
              title: todo['title'],
              completed: todo["completed"],
              id: todo['_id'],
            ),
          )
          .toList();
    } else if (response.statusCode == 400) {
      throw AuthenticationException(resbody["message"]);
    } else {
      throw ServerException(resbody["message"]);
    }
  }

  @override
  Future<TodoEntity> updateTodo(String id, String? title, bool? completed) async {
    final http.Response response = await client.delete(
      Uri.https('localhost:5000', 'api/todo/$id'),
      headers: {'Content-Type': 'application/json'},
      body: {
       "title": title,
       "completed": completed,
      }
    );

    final resbody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return TodoEntity(
        title: resbody["todo"]['title'],
        completed: resbody["todo"]['completed'],
        id: resbody["todo"]['_id'],
      );
    } else if (response.statusCode == 400) {
      throw AuthenticationException(resbody["message"]);
    } else {
      throw ServerException(resbody["message"]);
    }
  }
}
