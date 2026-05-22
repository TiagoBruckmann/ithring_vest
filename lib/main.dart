import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(() async {
    runApp();
  }, (error, stack) async {
    String message = "${error.toString()} - ${stack.toString()}";
  });
}