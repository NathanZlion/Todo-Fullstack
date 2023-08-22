import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/auth/data/models/user_model.dart';
import 'package:mobile/features/auth/domain/entities/user.dart';

import '../../../../helper/json_reader.dart';

void main() {
  const tUserModel =
      UserModel(userName: "test username", email: 'testemail@email.com');
  test('Should be a subclass of User Entity', () {
    // assert
    expect(tUserModel, isA<UserEntity>());
  });

  test('Should return a valid `UserModel` when fromJson is called', () {
    // arrange
    final userJson = jsonDecode(jsonReader("user.json"));

    // act
    final result = UserModel.fromJson(userJson);

    // assert
    expect(result, tUserModel);
  });

  test("Should return a valid user json when toJson is called", () {
    // arrange
    final expectedJson = {
      "userName": "test username",
      "email": "testemail@email.com"
    };

    // act
    final result = tUserModel.toJson();

    // assert
    expect(result, expectedJson);
  });
}
