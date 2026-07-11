import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:ithring_vest/core/domain/source/local/injection/injection.dart';
import 'package:ithring_vest/core/domain/source/local/mobx/user/user_mobx.dart';
import 'package:ithring_vest/design_system/widgets/financial_score_widget.dart';
import 'package:ithring_vest/design_system/widgets/verify_connection_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {

    final userMobx = getIt<UserMobx>();
    final theme = Theme.of(context);

    return VerifyConnectionWidget(
      popFunction: () => userMobx.exitApp(),
      canPop: false,
      keyAppBar: "pages.dashboard.greetings.evening",
      appBarParams: {"name": userMobx.user.name},
      child: Column(
        children: [

          Container(
            padding: EdgeInsets.symmetric( horizontal: 15, vertical: 8 ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: AlignmentGeometry.topLeft,
                end: AlignmentGeometry.bottomCenter,
                colors: [
                  theme.colorScheme.secondary,
                  theme.snackBarTheme.backgroundColor!,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      FlutterI18n.translate(context, "pages.dashboard.total_patrimony"),
                      style: theme.textTheme.titleSmall,
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.remove_red_eye_outlined,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),

                  ],
                ),

                Text(
                  "R\$ 100.020,00",
                  style: theme.textTheme.headlineLarge,
                ),

                Divider(
                  height: 30,
                  thickness: 0.5,
                  color: theme.colorScheme.onSurface,
                ),

                Text(
                  FlutterI18n.translate(context, "pages.dashboard.main_account"),
                  style: theme.textTheme.titleSmall,
                ),

                Padding(
                  padding: const EdgeInsets.only( top: 5),
                  child: Text(
                    "R\$ 80.580,00",
                    style: theme.textTheme.titleLarge,
                  ),
                ),

              ],
            ),
          ),

          FinancialScoreWidget(),

        ],
      ),
    );
  }
}
