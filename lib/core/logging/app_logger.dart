import 'package:flutter/foundation.dart';

abstract class AppLogger {
  void debug(String message, [Object? error, StackTrace? stackTrace]);
  void info(String message, [Object? error, StackTrace? stackTrace]);
  void warning(String message, [Object? error, StackTrace? stackTrace]);
  void error(String message, [Object? error, StackTrace? stackTrace]);
}

class ConsoleLogger implements AppLogger {
  const ConsoleLogger();

  @override
  void debug(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('[DEBUG] $message${error != null ? ' | $error' : ''}');
    }
  }

  @override
  void info(String message, [Object? error, StackTrace? stackTrace]) {
    debugPrint('[INFO] $message${error != null ? ' | $error' : ''}');
  }

  @override
  void warning(String message, [Object? error, StackTrace? stackTrace]) {
    debugPrint('[WARN] $message${error != null ? ' | $error' : ''}');
  }

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    debugPrint('[ERROR] $message${error != null ? ' | $error' : ''}');
    if (stackTrace != null) {
      debugPrint(stackTrace.toString());
    }
  }
}
