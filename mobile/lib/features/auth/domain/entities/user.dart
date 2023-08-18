import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userName;
  final String email;

  const UserEntity({required this.userName, required this.email});

  @override
  List<Object?> get props => [userName, email];
}
