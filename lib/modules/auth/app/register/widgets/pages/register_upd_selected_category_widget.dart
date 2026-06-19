import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:ithring_vest/core/domain/entities/coin_entity.dart';
import 'package:ithring_vest/design_system/widgets/default_button.dart';
import 'package:ithring_vest/modules/auth/app/register/cubit/register_cubit.dart';
import 'package:ithring_vest/modules/auth/app/register/widgets/register_header_widget.dart';
import 'package:ithring_vest/session.dart';

class RegisterUpdSelectedCategoryWidget extends StatelessWidget {
  final RegisterCubit cubit;
  final RegisterCategoriesSelectedState state;
  const RegisterUpdSelectedCategoryWidget({ super.key, required this.cubit, required this.state });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final defaultCoin = state.getDefaultCoin();

    return SingleChildScrollView(
      child: Form(
        key: Session.formKey,
        child: Column(
          children: [

            RegisterHeaderWidget(
              step: 3,
              title: "pages.login.upd_selected_categories.welcome",
              subtitle: "pages.login.upd_selected_categories.subtitle",
            ),

            for ( final category in state.categories )
              Padding(
                padding: const EdgeInsets.only( bottom: 10 ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [

                      ListTile(
                        leading: category.icon,
                        title: Text(
                          FlutterI18n.translate(context, category.name),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB( 10, 0, 10, 10 ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only( bottom: 5 ),
                                    child: Text(
                                      FlutterI18n.translate(context, "pages.login.upd_selected_categories.monthly_limit"),
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                  ),

                                  TextFormField(
                                    controller: state.getController(category.id),
                                    keyboardType: TextInputType.number,
                                    validator: (value) => Session.fieldsValidation.validateValueLimitCategory(value ?? ""),
                                    onChanged: (value) => cubit.updateValueLimitCategory(category.id, value),
                                    decoration: InputDecoration(
                                      hintText: Session.coinFormatter.doubleToCoin(10.50),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: theme.inputDecorationTheme.errorBorder!.borderSide,
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only( bottom: 5 ),
                                    child: Text(
                                      FlutterI18n.translate(context, "pages.login.upd_selected_categories.default_coin"),
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                  ),

                                  Checkbox(
                                    value: category.isDefaultCoin,
                                    onChanged: (value) => cubit.toggleDefaultCoinUpdSelectedCategory(category),
                                  ),

                                ],
                              ),
                            ),

                          ],
                        ),
                      ),

                      Visibility(
                        visible: !category.isDefaultCoin,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.only( left: 12 ),
                              child: Text(
                                FlutterI18n.translate(context, "pages.login.upd_selected_categories.coin"),
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 5 ),
                              child: PopupMenuButton<CoinEntity>(
                                initialValue: defaultCoin,
                                onSelected: ( CoinEntity itemSelected ) => cubit.selectCoin(itemSelected, category: category),
                                child: Card(
                                  elevation: 0,
                                  color: theme.inputDecorationTheme.fillColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: theme.inputDecorationTheme.border!.borderSide,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Text(
                                          category.coinAcronym ?? defaultCoin.acronym,
                                          style: const TextStyle(fontWeight: FontWeight.w600),
                                        ),

                                        const SizedBox(width: 8),

                                        const Icon(
                                          Icons.keyboard_arrow_down,
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                itemBuilder: (builder) {

                                  return state.coins.map(( coin ) {
                                    return PopupMenuItem<CoinEntity>(
                                      value: coin,
                                      child: Text(
                                        coin.acronym,
                                      ),
                                    );
                                  }).toList();

                                },
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),

            DefaultButton(
              function: () => cubit.validateUpdSelectedCategories(),
              text: "shared.btn_continue",
            ),

          ],
        ),
      ),
    );
  }
}
