import 'package:mobile/features/auth/domain/entities/success.dart';

abstract class AuthRemoteDataSource {
  /// Tries to login with the credentials
  /// 
  /// If there is some error it throws an Exception.
  Future<AuthSuccessEntity> login(
    String? email,
    String? password,
  );

  /// It Tries to regester as a new user
  /// 
  /// If errors occur it throws an Exception.
  Future<AuthSuccessEntity> register(
    String? userName,
    String? email,
    String? password,
  );
}

