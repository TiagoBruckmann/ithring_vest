import 'package:flutter/material.dart';
import 'package:ithring_vest/core/domain/sources/local/app_logs.dart';
import 'package:ithring_vest/core/domain/sources/remote/app_events.dart';
import 'package:ithring_vest/core/domain/sources/remote/performance.dart';
import 'package:ithring_vest/core/routes/navigation.dart';

class Session {

  static final globalContext = GlobalKey<NavigatorState>();

  static final FieldsValidationUtils fieldsValidation = FieldsValidationUtils();
  static final FieldsFormatters fieldsFormatters = FieldsFormatters();
  static final CoinFormatters coinFormatters = CoinFormatters();
  static final Performance performance = Performance();
  static final Navigation navigation = Navigation();
  static final SharedUtils utils = SharedUtils();
  static final AppEvents appEvents = AppEvents();
  static UserEntity user = UserEntity.empty();
  static final AppLogs logs = AppLogs();

}