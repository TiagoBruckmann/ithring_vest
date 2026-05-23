import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ithring_vest/design_system/style/app_images.dart';
import 'package:ithring_vest/design_system/widgets/verify_connection_widget.dart';
import 'package:ithring_vest/modules/auth/routes/auth_path.dart';
import 'package:ithring_vest/modules/auth/routes/auth_route.dart';
import 'package:ithring_vest/session.dart';

class RouterRegister {

  static final GoRouter router = GoRouter(
    navigatorKey: Session.globalContext,
    initialLocation: AuthPath.splashPath.splash,
    errorBuilder: ( context, state ) => _errorRoute( context ),
    routes: [
      ...AuthRoute.getInstance().routes,
      // ...DashRoute.getInstance().routes,
      // ...SettingsRoute.getInstance().routes,
      // ...NewSaleRoute.getInstance().routes,
    ],
  );

  static Widget _errorRoute( BuildContext context ) {

    final theme = Theme.of(context);

    return VerifyConnectionWidget(
      keyAppBar: "routes.app_bar",
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SvgPicture.asset(
              AppImages.logo,
              height: 180,
            ),

            Padding(
              padding: const EdgeInsets.only( top: 25, bottom: 50 ),
              child: Text(
                FlutterI18n.translate(context, "routes.subtitle"),
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                child: Text(
                  FlutterI18n.translate(context, "routes.back_home"),
                ),
                onPressed: () {
                  if ( Session.user.id.trim().isNotEmpty ) {
                    // return Session.navigation.go(DashPath.dashboardPath.dash);
                    return;
                  }

                  return Session.navigation.go(AuthPath.loginPath.login);
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

}