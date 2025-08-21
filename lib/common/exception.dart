class ServerException implements Exception {
  final String message;

  ServerException({required this.message});
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException({required this.message});
}
