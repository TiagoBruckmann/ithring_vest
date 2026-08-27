import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ithring_vest/core/domain/source/local/injection/injection.dart';
import 'package:ithring_vest/core/domain/source/local/mobx/user/user_mobx.dart';
import 'package:ithring_vest/design_system/widgets/circular_progress_painter.dart';

class FinancialScoreWidget extends StatelessWidget {
  final bool showSeeDetailsBtn;
  const FinancialScoreWidget({ super.key, this.showSeeDetailsBtn = true });

  @override
  Widget build(BuildContext context) {

    final userMobx = getIt<UserMobx>();
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.primaryColor,
          width: 1,
        ),
      ),
      child: Observer(
        builder: (context) {

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        FlutterI18n.translate(context, "pages.financial_score.title"),
                        style: theme.textTheme.titleMedium!.apply(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Container(
                        height: 1,
                        width: 28,
                        color: theme.colorScheme.onSurface,
                      ),

                    ],
                  ),

                  Icon(
                    Icons.chevron_right,
                    color: theme.colorScheme.onSurface,
                    size: 22,
                  ),

                ],
              ),

              const SizedBox(height: 20),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(
                    width: 110,
                    height: 110,
                    child: CustomPaint(
                      painter: CircularProgressPainter(
                        progress: userMobx.user.financialHealth.percentage / 100,
                        primaryColor: ( userMobx.user.financialHealth.percentage > 80 )
                        ? theme.colorScheme.error
                        : ( userMobx.user.financialHealth.percentage > 50 )
                        ? theme.colorScheme.onTertiary
                        : theme.primaryColor,
                        backgroundColor: theme.snackBarTheme.backgroundColor!,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text(
                              userMobx.user.financialHealth.percentage.toString(),
                              style: theme.textTheme.headlineMedium,
                            ),

                            const SizedBox(height: 2),

                            Text(
                              "/100",
                              style: theme.textTheme.titleMedium!.apply(
                                color: theme.colorScheme.onSurface,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          FlutterI18n.translate(context, "pages.financial_score.${userMobx.user.financialHealth.name}.title"),
                          style: theme.textTheme.titleMedium!.apply(
                            color: theme.primaryColor,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          ( userMobx.user.financialHealth.detailedMessage != null )
                            ? FlutterI18n.translate(context, "pages.financial_score.detailed_message.${userMobx.user.financialHealth.detailedMessage}")
                            : FlutterI18n.translate(context, "pages.financial_score.${userMobx.user.financialHealth.name}.subtitle"),
                          style: theme.textTheme.titleSmall,
                        ),

                        Visibility(
                          visible: showSeeDetailsBtn,
                          child: Padding(
                            padding: const EdgeInsets.only( top: 10 ),
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 6,
                                ),
                                side: BorderSide(
                                  color: theme.primaryColor,
                                  width: 0.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                FlutterI18n.translate(context, "pages.financial_score.btn_details"),
                                style: theme.textTheme.titleSmall,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ],
          );

        }
      ),
    );

    /*
    return Card(
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: theme.primaryColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 0, 5),
            child: Text(
              FlutterI18n.translate(context, "pages.financial_score.title"),
              style: theme.textTheme.titleSmall,
            ),
          ),

          Observer(
            builder: (context) {

              return ListTile(
                titleAlignment: ListTileTitleAlignment.top,
                leading: _CircularScoreIndicator(
                  score: userMobx.user.financialHealth.percentage,
                ),
                title: Text(
                  FlutterI18n.translate(context, "pages.financial_score.${userMobx.user.financialHealth.name}.title"),
                  style: theme.textTheme.titleSmall!.apply(
                    color: theme.primaryColor,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      userMobx.user.financialHealth.detailedMessage != null
                          ? FlutterI18n.translate(context, "pages.financial_score.detailed_message.${userMobx.user.financialHealth.detailedMessage}")
                          : FlutterI18n.translate(context, "pages.financial_score.${userMobx.user.financialHealth.name}.subtitle"),
                      style: theme.textTheme.titleSmall,
                    ),

                    Visibility(
                      visible: showSeeDetailsBtn,
                      child: Padding(
                        padding: const EdgeInsets.only( top: 5 ),
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: theme.primaryColor,
                                width: 0.5
                            ),
                          ),
                          child: Text(
                            FlutterI18n.translate(context, "pages.financial_score.btn_details"),
                            style: theme.textTheme.titleSmall,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                ),
              );

            }
          ),

        ],
      ),
    );
    */
  }
}
