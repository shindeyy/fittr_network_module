import 'dart:io';
import 'package:fittr_network_module/core/logger/app_logger.dart';
import 'package:logger/logger.dart';
import 'package:flutter/services.dart';

class PlatformSpecificLogOutput extends LogOutput {
  static const platform = MethodChannel('com.example/log');

  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      if (Platform.isAndroid) {
        _logToAndroid(line);
      } else if (Platform.isIOS) {
        _logToIOS(line);
      } else {
        AppLogger.d("In Else of PlatformSpecificLogOutput()");
      }
    }
  }

  void _logToAndroid(String message) {
    // Implement Android logging, if necessary
    platform.invokeMethod('log', {'message': message});
  }

  void _logToIOS(String message) {
    // Implement iOS logging, if necessary
    platform.invokeMethod('log', {'message': message});
  }
}
