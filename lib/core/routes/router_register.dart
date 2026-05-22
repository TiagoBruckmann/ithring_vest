import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class RouterRegister {

  /*
  static final GoRouter router = GoRouter(
    navigatorKey: Session.globalContext,
    initialLocation: AuthPath.splashPath.splash,
    errorBuilder: ( context, state ) => _errorRoute( context ),
    routes: [
      ...AuthRoute.getInstance().routes,
      ...DashRoute.getInstance().routes,
      ...SettingsRoute.getInstance().routes,
      ...NewSaleRoute.getInstance().routes,
    ],
  );

  static Widget _errorRoute( BuildContext context ) {

    final theme = Theme.of(context);

    return VerifyConnectionWidget(
      keyAppBar: "routes.app_bar",
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SvgPicture.asset(
              AppImages.pageNotFound,
              height: 180,
            ),

            Padding(
              padding: const EdgeInsets.only( top: 25, bottom: 50 ),
              child: Text(
                FlutterI18n.translate(context, "routes.subheading"),
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
                onPressed: () => Session.navigation.go(DashPath.dashboardPath.dash),
              ),
            ),

          ],
        ),
      ),
    );
  }
   */

}