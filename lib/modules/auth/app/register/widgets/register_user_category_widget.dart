import 'package:flutter/material.dart';
import 'package:ithring_vest/design_system/widgets/category_card_widget.dart';
import 'package:ithring_vest/modules/auth/app/register/cubit/register_cubit.dart';
import 'package:ithring_vest/modules/auth/app/register/widgets/register_header_widget.dart';

class RegisterUserCategoryWidget extends StatelessWidget {
  final RegisterCubit cubit;
  final RegisterCategoriesState state;
  const RegisterUserCategoryWidget({ super.key, required this.cubit, required this.state });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
      
          RegisterHeaderWidget(
            step: 2,
            title: "pages.login.register_categories.welcome",
            subtitle: "pages.login.register_categories.subtitle",
          ),
      
          for ( final category in state.categories )
            CategoryCardWidget(
              category: category,
            ),
      
        ],
      ),
    );
  }
}
