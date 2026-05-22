import 'package:firebase_performance/firebase_performance.dart';
import 'package:ithring_vest/session.dart';

class Performance {

  final FirebasePerformance _performance = FirebasePerformance.instance;

  HttpMetric newHttpMetric( String url, HttpMethod method ) {
    Session.appEvents.sharedEventString("http_request_$method", url);
    return _performance.newHttpMetric(url, method);
  }

}