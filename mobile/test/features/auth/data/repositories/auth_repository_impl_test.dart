import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/network/network_info.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mobile/features/auth/domain/entities/success.dart';
import 'package:mobile/features/auth/domain/entities/user.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mobile/core/error/exceptions.dart';
import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([NetworkInfo])
@GenerateNiceMocks(
    [MockSpec<AuthRemoteDataSource>(), MockSpec<AuthLocalDataSource>()])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockAuthLocalDataSource mockAuthLocalDataSource;

  var tExceptionMessage = 'Test Exception Message';

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(
      networkInfo: mockNetworkInfo,
      remoteDataSource: mockAuthRemoteDataSource,
      localDataSource: mockAuthLocalDataSource,
    );
  });

  group("login", () {
    const String tEmail = "testEmail";
    const String tUserName = "Nath";
    final AuthSuccessEntity tAuthSuccesEntity = AuthSuccessEntity(
      user: const UserEntity(email: tEmail, userName: tUserName),
      token: "token",
    );
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

      test("Should return a ServerFailure on server exception", () async {
        //  arrange
        when(mockAuthRemoteDataSource.login(any, any))
            .thenThrow(ServerException(tExceptionMessage));

        // act
        var result = await repository.login(tEmail, tPassword);

        //assert
        expect(result, Left(ServerFailure()));
      });

      test("Should return a Authentication Failure on Authentication exception",
          () async {
        //  arrange
        when(mockAuthRemoteDataSource.login(any, any))
            .thenThrow(AuthenticationException(tExceptionMessage));

        // act
        var result = await repository.login(tEmail, tPassword);

        //assert
        expect(result, Left(AuthenticationFailure()));
      });
    });

    group("Device is Offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test("Should return a Network failure when the device is offline",
          () async {
        // arrange
        when(mockAuthRemoteDataSource.login(any, any))
            .thenThrow(AuthenticationException(tExceptionMessage));

        // act
        var result = await repository.login(tEmail, tPassword);

        // assert
        expect(result, Left(NetworkFailure()));
      });
    });
  });

  group("register", () {
    const String tUserName = "Nath";
    const String tEmail = "testEmail";
    final AuthSuccessEntity tAuthSuccesEntity = AuthSuccessEntity(
      user: const UserEntity(email: tEmail, userName: tUserName),
      token: "token",
    );
    const String tPassword = "test password";
    test("Should check for connection when register is called on repository",
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.register(tUserName, tEmail, tPassword);
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
        when(mockAuthRemoteDataSource.register(any, any, any))
            .thenAnswer((_) async => tAuthSuccesEntity);

        final result = await repository.register(tUserName, tEmail, tPassword);

        verify(mockAuthRemoteDataSource.register(tUserName, tEmail, tPassword))
            .called(1);
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
        expect(result, Right(tAuthSuccesEntity));
      });

      test("Should return a ServerFailure on server exception", () async {
        //  arrange
        when(mockAuthRemoteDataSource.register(any, any, any))
            .thenThrow(ServerException(tExceptionMessage));

        // act
        var result = await repository.register(tUserName, tEmail, tPassword);

        //assert
        expect(result, Left(ServerFailure()));
      });

      test("Should return a Authentication Failure on Authentication exception",
          () async {
        //  arrange
        when(mockAuthRemoteDataSource.register(any, any, any))
            .thenThrow(AuthenticationException(tExceptionMessage));

        // act
        var result = await repository.register(tUserName, tEmail, tPassword);

        //assert
        expect(result, Left(AuthenticationFailure()));
      });
    });

    group("Device is Offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test("Should return a Network failure when the device is offline",
          () async {
        // arrange
        when(mockAuthRemoteDataSource.register(any, any, any))
            .thenThrow(AuthenticationException(tExceptionMessage));

        // act
        var result = await repository.register(tUserName, tEmail, tPassword);

        // assert
        expect(result, Left(NetworkFailure()));
      });
    });
  });
}
