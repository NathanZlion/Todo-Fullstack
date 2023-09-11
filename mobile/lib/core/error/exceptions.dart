class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class AuthenticationException implements Exception {
  final String message;

  const AuthenticationException(this.message);
}

class NetworkException implements Exception {
  final String message;

  const NetworkException(this.message);
}

class CacheException implements Exception {}
