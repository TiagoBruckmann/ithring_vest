import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ithring_vest/core/domain/source/local/injection/injection.dart';
import 'package:ithring_vest/core/routes/router_register.dart';
import 'package:ithring_vest/core/services/firebase_options.dart';
import 'package:ithring_vest/core/services/language_service.dart';
import 'package:ithring_vest/design_system/style/theme/themes.dart';
import 'package:ithring_vest/session.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseAppCheck.instance.activate();
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    PlatformDispatcher.instance.onError = (error, stackTrace) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
      return true;
    };

    await FirebasePerformance.instance.setPerformanceCollectionEnabled(!kDebugMode);

    // await Session.notifications.init();
    // Session.notifications.receiveNotification();

    await configureDependencies();

    runApp(
      OverlaySupport(
        child: MaterialApp.router(
          routerConfig: RouterRegister.router,
          title: "IthringVest",
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          supportedLocales: supportedLocale,
          localizationsDelegates: localizationsDelegate,
          debugShowCheckedModeBanner: false,
          builder: ( context, child ) {

            final theme = Theme.of(context);

            return Scaffold(
              backgroundColor: theme.scaffoldBackgroundColor,
              body: child,
            );

          },
        ),
      ),
    );
  }, (error, stack) async {
    Session.crash.onError("error main", error: error, stackTrace: stack);
  });
}