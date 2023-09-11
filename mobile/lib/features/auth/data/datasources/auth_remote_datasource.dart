import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';
import '../../domain/entities/success.dart';

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

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthSuccessEntity> login(
    String? email,
    String? password,
  ) async {
    // sent request to the remote server to login the user.
    final http.Response response = await client.post(
      Uri.https('localhost:5000', 'api/user/login'),
      headers: {'Content-Type': 'application/json'},
      body: {
        'email': email,
        "password": password,
      },
    );

    return _getresponse(response);
  }

  @override
  Future<AuthSuccessEntity> register(
    String? userName,
    String? email,
    String? password,
  ) async {
    final http.Response response =
        await client.post(Uri.https('localhost:5000', 'api/user/register'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'userName': userName,
              'email': email,
              'password': password,
            }));

    return _getresponse(response);
  }

  AuthSuccessEntity _getresponse(http.Response response) {
    if (response.statusCode == 200) {
      return AuthSuccessEntity(
        user: UserModel.fromJson(jsonDecode(response.body)['user']),
        token: jsonDecode(response.body)['token'],
      );
    } else if (response.statusCode == 400) {
      throw AuthenticationException(jsonDecode(response.body)["message"]);
    } else {
      throw ServerException(jsonDecode(response.body)["message"]);
    }
  }
}
