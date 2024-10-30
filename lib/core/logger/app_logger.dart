import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0, // Number of stack trace methods to show
      errorMethodCount: 5, // Number of method calls for errors
      lineLength: 80, // The width of the output
      colors: true, // Enable or disable colors
      printEmojis: true, // Enable or disable emojis
      dateTimeFormat:
          DateTimeFormat.dateAndTime, // Enable or disable timestamps
    ),
    //output: PlatformSpecificLogOutput(), // Use custom log output
  );

  // Log Debug
  static void d(String message) {
    _logger.d(message);
  }

  // Log Information
  static void i(String message) {
    _logger.i(message);
  }

  // Log Warning
  static void w(String message) {
    _logger.w(message);
  }

  // Log Error
  static void e(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, stackTrace: stackTrace);
  }

  // Log Verbose
  static void v(String message) {
    _logger.v(message);
  }
}
