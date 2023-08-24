import 'package:mobile/features/auth/data/models/user_model.dart';
import 'package:mobile/features/auth/domain/entities/success.dart';

class AuthSuccessModel extends AuthSuccessEntity {
  final UserModel user;
  final String token;

  AuthSuccessModel({
    required this.user,
    required this.token,
  }) : super(user: user, token: token);

  factory AuthSuccessModel.fromJson(Map<String, dynamic> json) {
    return AuthSuccessModel(
        user: UserModel.fromJson(json['user']), token: json['token']);
  }
}
