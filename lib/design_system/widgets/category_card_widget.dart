import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:ithring_vest/core/domain/entities/category_entity.dart';
import 'package:ithring_vest/session.dart';

class CategoryCardWidget extends StatelessWidget {
  final CategoryEntity category;
  const CategoryCardWidget({ super.key, required this.category });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    Color color = Color(0xFF9B4AEA);
    if ( category.isRevenue ) {
      color = Color(0xFF06C97C);
    } else if ( category.isEssentialExpense ) {
      color = Color(0xFF2397F7);
    }

    return Padding(
      padding: const EdgeInsets.only( bottom: 6 ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: theme.colorScheme.tertiary.withValues(alpha: 0.3),
          ),
        ),
        child: ListTile(
          leading: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: category.icon.color!.withValues(alpha: 0.3),
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              child: category.icon,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Text(
                FlutterI18n.translate(context, category.name),
                style: theme.textTheme.bodyLarge,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Text.rich(
                        TextSpan(
                          text: ( category.isRevenue )
                            ? FlutterI18n.translate(context, "pages.categories.revenue")
                            : ( category.isEssentialExpense )
                            ? FlutterI18n.translate(context, "pages.categories.essential_category")
                            : FlutterI18n.translate(context, "pages.categories.non_essential_category"),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: color,
                          ),
                          children: [

                            TextSpan(
                              text: " Mensal",
                              style: theme.textTheme.bodyMedium,
                            ),

                          ],
                        ),
                      ),

                      Text(
                        "${Session.coinFormatter.doubleToCoin(category.valueSpent)} / ${Session.coinFormatter.doubleToCoin(category.valueLimit)}",
                        style: theme.textTheme.bodyMedium,
                      ),

                    ],
                  ),

                  Text(
                    Session.coinFormatter.doubleToPercentage(category.percentage),
                    style: theme.textTheme.titleLarge!.apply(
                      color: color,
                    ),
                  ),

                ],
              ),

            ],
          ),
          subtitle: LinearProgressIndicator(
            minHeight: 5,
            value: category.percentage / 100,
            color: color,
          ),
        ),
      ),
    );
  }
}
