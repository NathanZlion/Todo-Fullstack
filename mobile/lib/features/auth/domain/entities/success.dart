import 'package:equatable/equatable.dart';

import 'user.dart';

class AuthSuccessEntity extends Equatable{
  late UserEntity user;
  late String token;

  AuthSuccessEntity({
    required this.user,
    required this.token,
  });
  
  @override
  List<Object?> get props => [user, token];
}
