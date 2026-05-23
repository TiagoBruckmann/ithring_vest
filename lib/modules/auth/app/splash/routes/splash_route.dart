import 'package:go_router/go_router.dart';
import 'package:ithring_vest/modules/auth/app/splash/routes/splash_path.dart';
import 'package:ithring_vest/modules/auth/app/splash/splash_page.dart';

class SplashRoute {
  static final _paths = SplashPath();
  static SplashRoute? _instance;

  static SplashRoute getInstance() => _instance ??= SplashRoute();

  final List<RouteBase> routes = [
    GoRoute(
      path: _paths.splash,
      builder: ( context, state ) => const SplashPage(),
    ),
  ];

}