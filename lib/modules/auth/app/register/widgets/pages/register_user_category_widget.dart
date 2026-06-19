import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:ithring_vest/core/domain/entities/category_entity.dart';
import 'package:ithring_vest/design_system/widgets/default_button.dart';
import 'package:ithring_vest/modules/auth/app/register/cubit/register_cubit.dart';
import 'package:ithring_vest/modules/auth/app/register/widgets/register_header_widget.dart';

class RegisterUserCategoryWidget extends StatelessWidget {
  final RegisterCubit cubit;
  final RegisterCategoriesState state;
  const RegisterUserCategoryWidget({ super.key, required this.cubit, required this.state });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    Widget buildSectionTitle( String labelKey ) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            FlutterI18n.translate(context, labelKey),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    Widget buildCategoryGrid( List<CategoryEntity> categories ) {
      if ( categories.isEmpty ) {
        return const SizedBox.shrink();
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (context, index) {

            final category = categories[index];
            final borderColor = category.isSelected ? theme.primaryColor : theme.colorScheme.tertiary.withValues(alpha: 0.3);
            final bgColor = category.isSelected ? theme.primaryColor.withValues(alpha:0.08) : theme.scaffoldBackgroundColor;

            return GestureDetector(
              onTap: () => cubit.toggleCategorySelection( category ),
              child: Stack(
                fit: StackFit.expand,
                children: [

                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: borderColor, width: 2),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        SizedBox(
                          height: 32,
                          width: 32,
                          child: Center(
                            child: IconTheme(
                              data: IconThemeData(
                                color: ( category.isSelected )
                                  ? theme.scaffoldBackgroundColor
                                  : theme.colorScheme.secondary,
                                size: 28,
                              ),
                              child: category.icon,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Flexible(
                          child: Text(
                            FlutterI18n.translate(context, category.name),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: ( category.isSelected )
                                ? theme.colorScheme.onPrimary
                                : theme.colorScheme.onSurface,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                  if ( category.isSelected )
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          Icons.check,
                          size: 14,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),

                ],
              ),
            );
          },
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [

          RegisterHeaderWidget(
            step: 2,
            title: "pages.login.register_categories.welcome",
            subtitle: "pages.login.register_categories.subtitle",
          ),

          const SizedBox(height: 8),

          buildSectionTitle("pages.login.register_categories.revenue_categories"),
          buildCategoryGrid(state.getRevenueCategoriesList()),

          const SizedBox(height: 18),

          buildSectionTitle("pages.login.register_categories.essential_categories"),
          buildCategoryGrid(state.getEssentialCategoriesList()),

          const SizedBox(height: 18),

          buildSectionTitle("pages.login.register_categories.other_categories"),

          buildCategoryGrid(state.getNonEssentialCategoriesList()),

          DefaultButton(
            function: () => cubit.validateCategoriesSelection(),
            text: "shared.btn_continue",
          ),

        ],
      ),
    );
  }
}
