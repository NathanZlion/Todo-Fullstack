import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/success.dart';
import '../../data/models/success_model.dart';

abstract class AuthLocalDataSource {
  /// Removes the cached [AuthSuccessEntity] which was gotten during the
  /// last successful login. If there was no successful login, this method
  /// does nothing.
  /// If the deletion of the cached data is not success full this throws a
  /// [CacheException]
  Future<void> logout();

  /// Caches the [AuthSuccessEntity] which was gotten during the
  /// last successful login.
  /// If the caching is not successfull it throws a [CacheException]
  Future<void> cacheAuthenticatedUser(AuthSuccessModel authSuccessModel);

  /// Gets the cached [AuthSuccessEntity] which was set into sharedpreference
  ///  during the last successful login.
  /// In case of an error it throws a [CacheException]
  Future<AuthSuccessEntity> getAuthenticatedUserData();
}

class AuthLocalDataSourcImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreference;

  AuthLocalDataSourcImpl(this.sharedPreference);

  @override
  Future<void> logout() async {
    try {
      sharedPreference.remove(LocalStorageConstants.cachedAuthInfo);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheAuthenticatedUser(AuthSuccessModel authSuccessModel) async {
    // here I should save the user's data to the shared preference
    final json = jsonEncode(authSuccessModel.toJson());
    try {
      sharedPreference.setString(LocalStorageConstants.cachedAuthInfo, json);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<AuthSuccessEntity> getAuthenticatedUserData() async {
    final authInfoEntityJson =
        sharedPreference.getString(LocalStorageConstants.cachedAuthInfo);
    if (authInfoEntityJson == null) throw CacheException();

    final authSuccessEntity =
        AuthSuccessModel.fromJson(jsonDecode(authInfoEntityJson));

    return Future.value(authSuccessEntity);
  }
}
