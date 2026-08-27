import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:graphic/graphic.dart';
import 'package:ithring_vest/core/domain/source/local/injection/injection.dart';
import 'package:ithring_vest/core/domain/source/local/mobx/user/user_mobx.dart';

class FinancialScoreWidget extends StatelessWidget {
  final bool showSeeDetailsBtn;
  const FinancialScoreWidget({ super.key, this.showSeeDetailsBtn = true });

  @override
  Widget build(BuildContext context) {

    final mediaQuerySize = MediaQuery.of(context).size;
    final userMobx = getIt<UserMobx>();
    final theme = Theme.of(context);

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
                leading: Stack(
                  children: [

                    /*
                        Container(
                          margin: const EdgeInsets.symmetric( vertical: 10 ),
                          height: 225,
                          child: Chart(
                            data: userMobx.financialHealth,
                            variables: {
                              "health": Variable(
                                accessor: ( Map item ) => item["name"] as String,
                              ),
                              "amount": Variable(
                                accessor: ( Map item ) => item["amount"] as num,
                              ),
                            },
                            transforms: [
                              Proportion(
                                variable: "amount",
                                as: "percent",
                              ),
                            ],
                            marks: [
                              IntervalMark(
                                position: Varset("percent") / Varset("health"),
                                color: ColorEncode(
                                  variable: "health",
                                  values: [
                                    theme.colorScheme.secondary,
                                    theme.colorScheme.inversePrimary,
                                    theme.colorScheme.error,
                                    theme.colorScheme.onTertiary,
                                  ],
                                ),
                                modifiers: [StackModifier()],
                              ),
                            ],
                            coord: PolarCoord(
                              transposed: true,
                              dimCount: 1,
                              startRadius: 0.8,
                            ),
                            selections: {
                              "tap": PointSelection(
                                on: {GestureType.tap},
                                clear: {},
                              ),
                            },
                          ),
                        ),
                        */

                    CircularProgressIndicator(
                      value: userMobx.user.financialHealth.percentage / 100,
                      backgroundColor: ( userMobx.user.financialHealth.percentage > 80 )
                          ? theme.colorScheme.error
                          : ( userMobx.user.financialHealth.percentage > 50 )
                          ? theme.colorScheme.onTertiary
                          : theme.primaryColor,
                      strokeWidth: 3,
                    ),

                    Positioned(
                      width: mediaQuerySize.width / 1.2,
                      top: mediaQuerySize.height / 7.4,
                      child: Text.rich(
                        TextSpan(
                          text: "${userMobx.user.financialHealth.percentage}\n",
                          children: [

                            TextSpan(
                              text: "/100",
                              style: theme.textTheme.bodySmall,
                            ),

                          ],
                        ),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium!.copyWith(
                          height: 0,
                        ),
                      ),
                    ),

                  ],
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

                    Visibility(
                      visible: userMobx.user.financialHealth.detailedMessage == null,
                      child: Text(
                        FlutterI18n.translate(context, "pages.financial_score.${userMobx.user.financialHealth.name}.subtitle"),
                        style: theme.textTheme.titleSmall,
                      ),
                    ),

                    Visibility(
                      visible: userMobx.user.financialHealth.detailedMessage != null,
                      child: Text(
                        FlutterI18n.translate(context, "pages.financial_score.detailed_message.${userMobx.user.financialHealth.detailedMessage}"),
                        style: theme.textTheme.titleSmall,
                      ),
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
  }
}
