import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:ithring_vest/core/domain/enums/monthly_flow_type_enum.dart';
import 'package:ithring_vest/session.dart';

class MonthlyFlowCardWidget extends StatelessWidget {
  final String title;
  final double amount;
  final MonthlyFlowTypeEnum monthlyFlowTypeEnum;
  const MonthlyFlowCardWidget({ super.key, required this.title, required this.amount, required this.monthlyFlowTypeEnum });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.canvasColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [

          Padding(
            padding: const EdgeInsets.only( bottom: 5 ),
            child: Text(
              FlutterI18n.translate(context, title).toUpperCase(),
              style: theme.textTheme.titleSmall,
            ),
          ),

          Text(
            Session.coinFormatter.doubleToCoin(amount),
            style: theme.textTheme.titleMedium!.apply(
              color: ( monthlyFlowTypeEnum == MonthlyFlowTypeEnum.revenues )
                  ? theme.primaryColor
                  : ( monthlyFlowTypeEnum == MonthlyFlowTypeEnum.expenses )
                  ? theme.colorScheme.error
                  : theme.colorScheme.secondary,
            ),
          ),

        ],
      ),
    );
  }
}
