import 'dart:math';
import 'package:ithring_vest/session.dart';
import 'package:url_launcher/url_launcher.dart';

class SharedUtils {

  final String _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString( int length ) {
    return String.fromCharCodes(
      Iterable.generate(
        length,
          (_) => _chars.codeUnitAt(
          _rnd.nextInt(_chars.length),
        ),
      ),
    );
  }

  String parseNumberLessThan10( int value ) {
    if ( value < 10 ) {
      return "0$value";
    }

    return value.toString();
  }

  String removeAllCharacters( String value ) {
    return value.replaceAll(RegExp(r'[^a-zA-Z0-9]'), "");
  }

  Future<void> openAppStore() async {

    Uri url = Uri.https("play.google.com", "store/apps/details", {
      "id": "dev.tiagobruckmann.ithring_vest",
    });

    if ( await canLaunchUrl( url ) ) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      String errorMessage = "Could not launch appStoreLink";
      Session.crash.onError("openAppStore", error: errorMessage);
      throw errorMessage;
    }
  }

}