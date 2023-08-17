import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userName;
  final String email;

  const 
  User({required this.userName, required this.email});

  @override
  List<Object?> get props => [userName, email];
}
