import 'package:mobile/features/auth/data/models/user_model.dart';
import 'package:mobile/features/auth/domain/entities/success.dart';

// ignore: must_be_immutable
class AuthSuccessModel extends AuthSuccessEntity {
  AuthSuccessModel({
    required user,
    required token,
  }) : super(user: user, token: token);

  factory AuthSuccessModel.fromJson(Map<String, dynamic> json) {
    return AuthSuccessModel(
      user: UserModel.fromJson(json['user']),
      token: json['token'],
    );
  }

  toJson() {
    return {
      'user': (user as UserModel).toJson(),
      'token': token,
    };
  }
}
