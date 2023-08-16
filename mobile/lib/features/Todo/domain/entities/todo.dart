import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String title;
  final bool completed;
  final String id;

  const Todo(this.title, this.completed, this.id);

  // "user": "64add466006627c57e3e11db",
  // "title": "Third to do.",
  // "completed": false,
  // "_id": "64dc9008872355b87f08627f",

  @override
  List<Object?> get props => [title, completed, id];
}
