import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}


class AuthorizationFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NetworkFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

