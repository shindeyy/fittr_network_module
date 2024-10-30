import 'package:dio/dio.dart';
import 'dart:io';

class DioErrorHandler {
  static String handleError(DioException error) {
    String errorDescription = '';
    switch (error.type) {
      case DioExceptionType.cancel:
        errorDescription = "Request to the server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        errorDescription = "Connection timeout with the server";
        break;
      case DioExceptionType.receiveTimeout:
        errorDescription = "Receive timeout in connection with the server";
        break;
      case DioExceptionType.sendTimeout:
        errorDescription = "Send timeout in connection with the server";
        break;
      case DioExceptionType.badResponse:
        errorDescription =
            "Received invalid status code: ${error.response?.statusCode}";
        break;
      case DioExceptionType.connectionError:
        if (error.error is SocketException) {
          errorDescription = "No internet connection";
        } else {
          errorDescription = "Connection error occurred: ${error.error}";
        }
        break;
      case DioExceptionType.badCertificate:
        errorDescription = "Bad SSL certificate";
        break;
      default:
        errorDescription = "Unexpected error occurred: ${error.message}";
        break;
    }

    return errorDescription;
  }
}
