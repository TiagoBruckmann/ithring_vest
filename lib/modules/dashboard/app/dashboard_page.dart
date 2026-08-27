import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ithring_vest/core/domain/enums/monthly_flow_type_enum.dart';
import 'package:ithring_vest/core/domain/source/local/injection/injection.dart';
import 'package:ithring_vest/core/domain/source/local/mobx/accounts/account_mobx.dart';
import 'package:ithring_vest/core/domain/source/local/mobx/categories/category_mobx.dart';
import 'package:ithring_vest/core/domain/source/local/mobx/user/user_mobx.dart';
import 'package:ithring_vest/design_system/widgets/financial_score_widget.dart';
import 'package:ithring_vest/design_system/widgets/verify_connection_widget.dart';
import 'package:ithring_vest/modules/dashboard/app/widgets/monthly_flow_card_widget.dart';
import 'package:ithring_vest/session.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {

    final categoryMobx = getIt<CategoryMobx>();
    final accountMobx = getIt<AccountMobx>();
    final userMobx = getIt<UserMobx>();
    final theme = Theme.of(context);

    return Observer(
      builder: (context) {

        return VerifyConnectionWidget(
          popFunction: () => userMobx.exitApp(),
          canPop: false,
          keyAppBar: "pages.dashboard.greetings.${userMobx.greeting}",
          appBarParams: {"name": userMobx.user.name},
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        Session.coinFormatter.doubleToCoin(accountMobx.totalPatrimonyAmount),
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
                          accountMobx.defaultAccountAmount,
                          style: theme.textTheme.titleLarge,
                        ),
                      ),

                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric( vertical: 10 ),
                  child: FinancialScoreWidget(),
                ),

                Padding(
                  padding: const EdgeInsets.only( top: 5, bottom: 5 ),
                  child: Text(
                    FlutterI18n.translate(context, "pages.dashboard.monthly_flow"),
                    style: theme.textTheme.titleMedium!.apply(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),

                Row(
                  spacing: 10,
                  children: [

                    Expanded(
                      child: MonthlyFlowCardWidget(
                        title: "shared.revenues",
                        amount: categoryMobx.revenueAmount,
                        monthlyFlowTypeEnum: MonthlyFlowTypeEnum.revenues,
                      ),
                    ),

                    Expanded(
                      child: MonthlyFlowCardWidget(
                        title: "shared.expenses",
                        amount: categoryMobx.expenseAmount,
                        monthlyFlowTypeEnum: MonthlyFlowTypeEnum.expenses,
                      ),
                    ),

                  ],
                ),

                Container(
                  padding: EdgeInsets.only( top: 5 ),
                  width: double.infinity,
                  child: MonthlyFlowCardWidget(
                    title: "shared.investments",
                    amount: 0,
                    monthlyFlowTypeEnum: MonthlyFlowTypeEnum.investments,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only( top: 5, bottom: 5 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        FlutterI18n.translate(context, "pages.dashboard.last_transactions"),
                        style: theme.textTheme.titleMedium!.apply(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      TextButton(
                        onPressed: () {},
                        child: Text(
                          FlutterI18n.translate(context, "pages.dashboard.see_all"),
                          style: theme.textTheme.titleSmall!.apply(
                            color: theme.primaryColor,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
        );

      }
    );
  }
}
