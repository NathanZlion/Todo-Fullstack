class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class AuthorizationException implements Exception {
  final String message;

  const AuthorizationException(this.message);
}

class NetworkException implements Exception {
  final String message;

  const NetworkException(this.message);
}
