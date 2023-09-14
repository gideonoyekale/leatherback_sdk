import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class Console {
  static void log(String tag, dynamic msg, {Object? error}) {
    // Application was compiled in debug mode?
    if (!kDebugMode) return;
    developer.log('$msg', time: DateTime.now(), name: tag, error: error);
  }
}
