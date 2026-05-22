import 'package:flutter/foundation.dart';
import 'dart:developer';

class AppLogs {

  void successLog( String message ) => _safePrint("\x1B[32m\u2714 $message\x1B[0m");
  void errorLog( String message ) => _safePrint("\x1B[31m\u2718 $message\x1B[0m");

  static void _safePrint( String value ) {
    if (kDebugMode) {
      log(value);
    }
  }

}