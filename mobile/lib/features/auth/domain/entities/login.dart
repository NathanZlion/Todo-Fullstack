import 'package:mobile/features/auth/domain/entities/user.dart';

class LoginEntity {
  late User user;
  late String token;

  LoginEntity({
    required this.user,
    required this.token,
  });
}
