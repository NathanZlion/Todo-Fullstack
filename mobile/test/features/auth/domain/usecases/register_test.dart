import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/auth/domain/entities/success.dart';
import 'package:mobile/features/auth/domain/entities/user.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile/features/auth/domain/usecases/register.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  const String tUserName = "NathanD";
  const String tEmail = "nathandere1357@gmail.com";
  const String tPassword = "\$Anbesaw1";
  const String tToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGFkZDQ2NjAwNjYyN2M1N2UzZTExZGIiLCJpYXQiOjE2OTIyMTgzMzd9.AnMr7kzu3lyy-PfGj1JCA85F-Du4l1KCkGyhlyb9qmA";

  late MockAuthRepository mockAuthRepository;
  late RegisterUseCase useCase;
  late AuthSuccessEntity registerResponse;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = RegisterUseCase(mockAuthRepository);
    registerResponse = AuthSuccessEntity(
      user: const UserEntity(userName: tUserName, email: tEmail),
      token: tToken,
    );
  });

  test("Should call AuthRepository when login use case is called", () async {
    // arrange
    when(mockAuthRepository.register(any, any, any))
        .thenAnswer((_) async => Right(registerResponse));

    // act
    var result = await useCase(
        const Params(userName: tUserName, email: tEmail, password: tPassword));

    // assert
    expect(result, equals(Right(registerResponse)));
    verify(mockAuthRepository.register(tUserName, tEmail, tPassword)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);   
  });
}
