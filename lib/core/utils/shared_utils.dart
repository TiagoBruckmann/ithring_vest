import 'dart:math';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:url_launcher/url_launcher.dart';

class SharedServices {

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