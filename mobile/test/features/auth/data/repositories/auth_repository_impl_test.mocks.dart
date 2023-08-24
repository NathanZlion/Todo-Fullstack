// Mocks generated by Mockito 5.4.0 from annotations
// in mobile/test/features/auth/data/repositories/auth_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mobile/core/Network/network_info.dart' as _i3;
import 'package:mobile/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i5;
import 'package:mobile/features/auth/domain/entities/success.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeAuthSuccessEntity_0 extends _i1.SmartFake
    implements _i2.AuthSuccessEntity {
  _FakeAuthSuccessEntity_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i3.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}

/// A class which mocks [AuthRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRemoteDataSource extends _i1.Mock
    implements _i5.AuthRemoteDataSource {
  @override
  _i4.Future<_i2.AuthSuccessEntity> login(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [
            email,
            password,
          ],
        ),
        returnValue:
            _i4.Future<_i2.AuthSuccessEntity>.value(_FakeAuthSuccessEntity_0(
          this,
          Invocation.method(
            #login,
            [
              email,
              password,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.AuthSuccessEntity>.value(_FakeAuthSuccessEntity_0(
          this,
          Invocation.method(
            #login,
            [
              email,
              password,
            ],
          ),
        )),
      ) as _i4.Future<_i2.AuthSuccessEntity>);
  @override
  _i4.Future<_i2.AuthSuccessEntity> register(
    String? userName,
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #register,
          [
            userName,
            email,
            password,
          ],
        ),
        returnValue:
            _i4.Future<_i2.AuthSuccessEntity>.value(_FakeAuthSuccessEntity_0(
          this,
          Invocation.method(
            #register,
            [
              userName,
              email,
              password,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.AuthSuccessEntity>.value(_FakeAuthSuccessEntity_0(
          this,
          Invocation.method(
            #register,
            [
              userName,
              email,
              password,
            ],
          ),
        )),
      ) as _i4.Future<_i2.AuthSuccessEntity>);
}
