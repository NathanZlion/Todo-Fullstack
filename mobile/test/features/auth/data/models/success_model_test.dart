import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/auth/data/models/success_model.dart';
import 'package:mobile/features/auth/data/models/user_model.dart';
import 'package:mobile/features/auth/domain/entities/success.dart';

import '../../../../helper/json_reader.dart';

void main() {
  const tUserName = "NathanD";
  const tEmail = "nathandere1357@gmail.com";
  const tUser = UserModel(userName: tUserName, email: tEmail);
  const tToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGFkZDQ2NjAwNjYyN2M1N2UzZTExZGIiLCJpYXQiOjE2OTIyNjMxOTV9.F-IeWwImZbZOv-4UpZAQGhYGcbzFutXrBuPO7TpqN4g";
  final AuthSuccessModel tAuthSuccessModel =
      AuthSuccessModel(user: tUser, token: tToken);

  test("Should be a subclass of the `AuthSucessEntity`", () {
    // assert
    expect(tAuthSuccessModel, isA<AuthSuccessEntity>());
  });

  test("Should return a valid AuthSuccessModel when fromJson is called", () {
    // arrange
    final tAuthSuccessJson = jsonDecode(jsonReader('auth_success.json'));

    // act
    final result = AuthSuccessModel.fromJson(tAuthSuccessJson);
    
    // assert
    expect(result.user.email, tAuthSuccessModel.user.email);
    expect(result.user.userName, tAuthSuccessModel.user.userName);
    expect(result.token, tAuthSuccessModel.token);
    expect(result, tAuthSuccessModel);
  });
}
