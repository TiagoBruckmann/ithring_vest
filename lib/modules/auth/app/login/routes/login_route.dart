import 'package:go_router/go_router.dart';
import 'package:ithring_vest/modules/auth/app/login/login_page.dart';
import 'package:ithring_vest/modules/auth/app/login/presentation_page.dart';
import 'package:ithring_vest/modules/auth/app/login/routes/login_path.dart';

class LoginRoute {
  static final _paths = LoginPath();
  static LoginRoute? _instance;

  static LoginRoute getInstance() => _instance ??= LoginRoute();

  final List<RouteBase> routes = [
    GoRoute(
      path: _paths.presentation,
      builder: ( context, state ) => const PresentationPage(),
    ),
    GoRoute(
      path: _paths.login,
      builder: ( context, state ) => const LoginPage(),
    ),
  ];

}