import 'package:flutter/material.dart';
import 'package:ithring_vest/core/domain/entities/user_entity.dart';
import 'package:ithring_vest/core/domain/source/local/local_storage.dart';
import 'package:ithring_vest/core/domain/source/remote/crash.dart';
import 'package:ithring_vest/core/domain/source/remote/performance.dart';
import 'package:ithring_vest/core/domain/source/local/app_logs.dart';
import 'package:ithring_vest/core/domain/source/remote/app_events.dart';
import 'package:ithring_vest/core/routes/navigation.dart';
import 'package:ithring_vest/core/services/notification_service.dart';
import 'package:ithring_vest/core/utils/fields_validation_utils.dart';
import 'package:ithring_vest/core/utils/shared_utils.dart';
import 'package:ithring_vest/design_system/formatters/coin_formatter.dart';
import 'package:ithring_vest/design_system/formatters/fields_formatter.dart';

class Session {

  static final globalContext = GlobalKey<NavigatorState>();
  static final formKey = GlobalKey<FormState>();

  static final FieldsValidationUtils fieldsValidation = FieldsValidationUtils();
  static final FieldsFormatter fieldsFormatter = FieldsFormatter();
  static final CoinFormatter coinFormatter = CoinFormatter();
  static final NotificationServices notifications = NotificationServices();
  static final LocalStorage localStorage = LocalStorage();
  static final Performance performance = Performance();
  static final Navigation navigation = Navigation();
  static final SharedUtils utils = SharedUtils();
  static final AppEvents appEvents = AppEvents();
  static UserEntity user = UserEntity.empty();
  static final AppLogs logs = AppLogs();
  static final Crash crash = Crash();

}