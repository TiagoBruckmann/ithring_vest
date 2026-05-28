import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:ithring_vest/core/domain/source/local/injection/injection.dart';
import 'package:ithring_vest/core/domain/source/local/mobx/user/user_mobx.dart';
import 'package:ithring_vest/design_system/style/app_images.dart';
import 'package:ithring_vest/design_system/widgets/ithring_vest_widget.dart';
import 'package:ithring_vest/modules/auth/routes/auth_path.dart';
import 'package:ithring_vest/session.dart';

class PresentationPage extends StatelessWidget {
  const PresentationPage({super.key});

  @override
  Widget build(BuildContext context) {

    final userMobx = getIt<UserMobx>();
    final theme = Theme.of(context);

    Widget buildFeatureCard( IconData icon, String title ) {
      return Row(
        children: [

          Icon(
            icon,
            size: 20,
          ),

          const SizedBox(width: 12),

          Text(
            FlutterI18n.translate(context, "pages.login.presentation.options.$title"),
            style: theme.textTheme.labelLarge,
          ),

        ],
      );
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: ( canPop, objet ) async => await userMobx.exitApp(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ( theme.brightness == Brightness.dark )
                ? AppImages.presentationDarkMode
                : AppImages.presentationLightMode,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [

                const SizedBox(height: 50),

                const IthringVestWidget(),

                const SizedBox(height: 20),

                Text.rich(
                  TextSpan(
                    text: FlutterI18n.translate(context, "pages.login.presentation.title1"),
                    style: theme.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    children: [

                      TextSpan(
                        text: FlutterI18n.translate(context, "pages.login.presentation.title2"),
                        style: theme.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  FlutterI18n.translate(context, "pages.login.presentation.subtitle"),
                  style: theme.textTheme.labelLarge,
                ),

                const SizedBox(height: 110),

                buildFeatureCard(Icons.redeem, "patrimony"),

                const SizedBox(height: 12),

                buildFeatureCard(Icons.credit_card, "cards"),

                const SizedBox(height: 12),

                buildFeatureCard(Icons.insights, "invest"),

                const SizedBox(height: 12),

                buildFeatureCard(Icons.public, "multi_currency"),

                const SizedBox(height: 110),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Session.navigation.push(AuthPath.registerPath.register),
                    child: Text(
                      FlutterI18n.translate(context, "pages.login.presentation.create_account"),
                      style: theme.textTheme.titleMedium!.apply(
                        color: theme.scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Session.navigation.push(AuthPath.loginPath.login),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    child: Text(
                      FlutterI18n.translate(context, "pages.login.presentation.have_account"),
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
