import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:ithring_vest/session.dart';

class NotificationServices {

  Future<void> init() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    // OneSignal.initialize(EnvSettings.onesignalAppId);
    await OneSignal.Notifications.requestPermission(true);
  }

  Future<void> login( String userId ) async {
    Session.logs.successLog("notification_login => $userId");
    return await OneSignal.login(userId);
  }

  Future<void> logout() async {
    Session.logs.successLog("notification_logOut");
    return await OneSignal.logout();
  }

  String? getPlayerId() {
    final playerId = OneSignal.User.pushSubscription.id;
    Session.logs.successLog("Onesignal PlayerId => $playerId");
    return playerId;
  }

  void receiveNotification() {
    _foreground();
    _closedApp();
  }

  static void _foreground() async {
    OneSignal.Notifications.addForegroundWillDisplayListener((event) async { });
  }

  static void _closedApp() {
    OneSignal.Notifications.addClickListener((event) async { });
  }
}