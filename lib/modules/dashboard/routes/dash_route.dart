import 'package:go_router/go_router.dart';
import 'package:ithring_vest/modules/dashboard/app/dashboard_page.dart';
import 'package:ithring_vest/modules/dashboard/routes/dash_path.dart';

class DashRoute {
  static final _paths = DashPath();
  static DashRoute? _instance;

  static DashRoute getInstance() => _instance ??= DashRoute();

  final List<RouteBase> routes = [
    GoRoute(
      path: _paths.dashboard,
      builder: ( context, state ) => const DashboardPage(),
    ),
  ];
}