import 'package:mobile/features/auth/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.userName,
    required super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(userName: json['userName'], email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
    };
  }
}
