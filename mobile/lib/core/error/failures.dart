import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

// here I am thinking of the different kinds of failures that could happen
// 1. Unauthorized access 404
// 2. Server Failure      500
// 3. 

class AuthorizationFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}
