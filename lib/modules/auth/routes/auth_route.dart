import 'package:go_router/go_router.dart';
import 'package:ithring_vest/modules/auth/app/login/routes/login_route.dart';
import 'package:ithring_vest/modules/auth/app/register/routes/register_route.dart';
import 'package:ithring_vest/modules/auth/app/splash/routes/splash_route.dart';

class AuthRoute {
  static AuthRoute? _instance;

  static AuthRoute getInstance() => _instance ??= AuthRoute();

  final List<RouteBase> routes = [
    ...RegisterRoute.getInstance().routes,
    ...SplashRoute.getInstance().routes,
    ...LoginRoute.getInstance().routes,
  ];

}