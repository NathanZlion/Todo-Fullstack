import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final String title;
  final bool completed;
  final String id;

  const TodoEntity({required this.title, required this.completed, required this.id});

  @override
  List<Object?> get props => [title, completed, id];
}
