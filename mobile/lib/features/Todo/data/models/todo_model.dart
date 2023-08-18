import 'package:mobile/features/todo/domain/entities/todo.dart';

class TodoModel extends TodoEntity {
  const TodoModel({
    required super.title,
    required super.completed,
    required super.id,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      title: json['title'],
      completed: json['completed'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'completed': completed,
    };
  }
}
