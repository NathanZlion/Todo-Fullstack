import 'package:mobile/features/todo/domain/entities/todo.dart';

class TodoModel extends TodoEntity {
  const TodoModel({
    required super.id,
    required super.title,
    required super.completed,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['_id'],
      title: json['title'],
      completed: json['completed'],
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
