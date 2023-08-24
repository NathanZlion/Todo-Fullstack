import 'package:dartz/dartz.dart';
import 'package:mobile/features/auth/domain/entities/success.dart';
import 'package:mobile/features/auth/domain/entities/user.dart';
import 'package:mobile/features/auth/domain/usecases/login.dart';
import 'package:mockito/mockito.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'login_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  const String tUserName = "NathanD";
  const String tEmail = "nathandere1357@gmail.com";
  const String tPassword = "\$Anbesaw1";
  const String tToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGFkZDQ2NjAwNjYyN2M1N2UzZTExZGIiLCJpYXQiOjE2OTIyMTgzMzd9.AnMr7kzu3lyy-PfGj1JCA85F-Du4l1KCkGyhlyb9qmA";

  late MockAuthRepository mockAuthRepository;
  late LoginUseCase useCase;
  late AuthSuccessEntity loginResponse;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LoginUseCase(mockAuthRepository);
    loginResponse = AuthSuccessEntity(
      user: const UserEntity(userName: tUserName, email: tEmail),
      token: tToken,
    );
  });
  test(
      'Should call AuthRepository when LoginUseCase is called and return the result.',
      () async {
    // arrange
    when(mockAuthRepository.login(any, any))
        .thenAnswer((_) async => Right(loginResponse));

    //act
    final result =
        await useCase(const Params(email: tEmail, password: tPassword));

    //assert
    expect(result, Right(loginResponse));
    verify(mockAuthRepository.login(tEmail, tPassword)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
