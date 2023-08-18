import 'user.dart';

class AuthSuccessEntity {
  late UserEntity user;
  late String token;

  AuthSuccessEntity({
    required this.user,
    required this.token,
  });
}
