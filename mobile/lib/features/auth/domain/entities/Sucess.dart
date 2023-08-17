import 'package:mobile/features/auth/domain/entities/user.dart';

class AuthSuccessEntity {
  late User user;
  late String token;

  AuthSuccessEntity({
    required this.user,
    required this.token,
  });
}
