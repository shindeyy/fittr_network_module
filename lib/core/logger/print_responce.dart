import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class PrintResponse {
  // Private constructor for Singleton
  PrintResponse._privateConstructor();

  // Static instance
  static final PrintResponse _instance = PrintResponse._privateConstructor();

  // Public getter for the instance
  static PrintResponse get instance => _instance;

  // Initialize the logger
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
    ),
  );

  // Function to print JSON with pretty formatting
  void logResponse(Map<String, dynamic> jsonData, Level logLevel) {
    const encoder = JsonEncoder.withIndent('  ');
    final prettyJson = encoder.convert(jsonData);
    _logger.log(logLevel, prettyJson);
  }

  // Function to log detailed error information
  void logErrorResponse(DioException error) {
    final request = error.requestOptions;
    final response = error.response;
    String errorDetails = '''
        --- Error Details ---
        URL: ${request.baseUrl}${request.path}
        Method: ${request.method}
        Headers: ${request.headers}
        Request Data: ${request.data}
        Status Code: ${response?.statusCode}
        Error Message: ${error.message}
        ${response != null && response.data is Map<String, dynamic> ? 'Response Data: ${response.data}' : 'No Response Data'}
        --- End Error Details ---
        ''';
    logMessage(errorDetails, Level.error);
  }

  // Function to print a simple string message
  void logMessage(String message, Level logLevel) {
    _logger.log(logLevel, message);
  }
}
