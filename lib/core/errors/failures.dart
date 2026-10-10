abstract class Failure {
  const Failure(this.message, [this.cause]);
  final String message;
  final Object? cause;

  @override
  String toString() =>
      '$runtimeType: $message${cause != null ? ' ($cause)' : ''}';
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message, [super.cause]);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message, [super.cause]);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message, [super.cause]);
}

class SyncFailure extends Failure {
  const SyncFailure(super.message, [super.cause]);
}

class StorageFailure extends Failure {
  const StorageFailure(super.message, [super.cause]);
}

class DomainException implements Exception {
  const DomainException(this.message, [this.cause]);
  final String message;
  final Object? cause;

  @override
  String toString() => 'DomainException: $message';
}
