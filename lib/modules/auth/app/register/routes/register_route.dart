import 'package:go_router/go_router.dart';
import 'package:ithring_vest/modules/auth/app/register/register_page.dart';
import 'package:ithring_vest/modules/auth/app/register/routes/register_path.dart';

class RegisterRoute {
  static final _paths = RegisterPath();
  static RegisterRoute? _instance;

  static RegisterRoute getInstance() => _instance ??= RegisterRoute();

  final List<RouteBase> routes = [
    GoRoute(
      path: _paths.register,
      builder: ( context, state ) => const RegisterPage(),
    ),
  ];

}