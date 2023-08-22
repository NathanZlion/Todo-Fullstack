import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/Network/network_info.dart';
import 'package:mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mobile/features/auth/domain/entities/success.dart';
import 'package:mobile/features/auth/domain/entities/user.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource, NetworkInfo])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(
      networkInfo: mockNetworkInfo,
      remoteDataSource: mockAuthRemoteDataSource,
    );
  });

  group("login", () {
    const String tEmail = "testEmail";
    const String tUserName = "Nath";
    final AuthSuccessEntity tAuthSuccesEntity = AuthSuccessEntity(
        user: const UserEntity(email: tEmail, userName: tUserName),
        token: "token");
    const String tPassword = "test password";
    test("Should check for connection when login is called on repository",
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.login(tEmail, tPassword);
      // assert
      verify(mockNetworkInfo.isConnected).called(1);
    });

    group("Device is Online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          "Should return a valid AuthSuccessEntity when the call for the remote data source is successfull",
          () async {
        when(mockAuthRemoteDataSource.login(any, any))
            .thenAnswer((_) async => tAuthSuccesEntity);

        final result = await repository.login(tEmail, tPassword);

        verify(mockAuthRemoteDataSource.login(tEmail, tPassword)).called(1);
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
        expect(result, Right(tAuthSuccesEntity));
      });
    });

    

    group("Device is Offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
    });
  });
}
