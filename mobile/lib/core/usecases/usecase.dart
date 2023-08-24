import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params param);
}


class NoParam extends Equatable {
  const NoParam();

  @override
  List<Object?> get props => [];
}