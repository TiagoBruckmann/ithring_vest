import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:ithring_vest/core/domain/entities/coin_entity.dart';
import 'package:ithring_vest/core/domain/entities/type_account_entity.dart';
import 'package:ithring_vest/design_system/widgets/default_button.dart';
import 'package:ithring_vest/modules/auth/app/register/cubit/register_cubit.dart';
import 'package:ithring_vest/modules/auth/app/register/widgets/register_header_widget.dart';
import 'package:ithring_vest/session.dart';

class RegisterAccountWidget extends StatelessWidget {
  final RegisterCubit cubit;
  final RegisterAccountsState state;
  const RegisterAccountWidget({ super.key, required this.cubit, required this.state });

  @override
  Widget build(BuildContext context) {
    
    final theme = Theme.of(context);

    Widget buildTypeAccountGrid( List<TypeAccountEntity> typeAccounts ) {
      if ( typeAccounts.isEmpty ) {
        return const SizedBox.shrink();
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: typeAccounts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (context, index) {

            final typeAccount = typeAccounts[index];
            final borderColor = typeAccount.isSelected ? theme.primaryColor : theme.colorScheme.tertiary.withValues(alpha: 0.3);
            final bgColor = typeAccount.isSelected ? theme.primaryColor.withValues(alpha:0.08) : theme.scaffoldBackgroundColor;

            return GestureDetector(
              onTap: () => cubit.toggleTypeAccountSelection( typeAccount ),
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

                        Visibility(
                          visible: typeAccount.icon != null,
                          child: SizedBox(
                            height: 32,
                            width: 32,
                            child: Center(
                              child: IconTheme(
                                data: IconThemeData(
                                  color: ( typeAccount.isSelected )
                                      ? theme.scaffoldBackgroundColor
                                      : theme.colorScheme.secondary,
                                  size: 28,
                                ),
                                child: typeAccount.icon!,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Flexible(
                          child: Text(
                            FlutterI18n.translate(context, typeAccount.name),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: ( typeAccount.isSelected )
                                  ? theme.colorScheme.onPrimary
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                  if ( typeAccount.isSelected )
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
      child: Form(
        key: Session.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            RegisterHeaderWidget(
              step: 4,
              title: "pages.login.register_account.welcome",
              subtitle: "pages.login.register_account.subtitle",
            ),

            Padding(
              padding: const EdgeInsets.only( left: 12, bottom: 5 ),
              child: Text(
                FlutterI18n.translate(context, "fields.account_name.label"),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            TextFormField(
              controller: state.nameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.words,
              validator: (value) => Session.fieldsValidation.validateNameAccount(value ?? ""),
              decoration: InputDecoration(
                hintText: FlutterI18n.translate(context, "fields.account_name.hint"),
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

            Padding(
              padding: const EdgeInsets.symmetric( vertical: 10 ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.only( left: 10, bottom: 5 ),
                    child: Text(
                      FlutterI18n.translate(context, "pages.login.register_account.coin"),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  PopupMenuButton<CoinEntity>(
                    initialValue: state.getDefaultCoin(),
                    onSelected: ( CoinEntity itemSelected ) => cubit.selectCoin(itemSelected),
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
                              "${state.defaultCoin.acronym} - ${FlutterI18n.translate(context, state.defaultCoin.name)}",
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
                            "${coin.acronym} - ${FlutterI18n.translate(context, coin.name)}",
                          ),
                        );
                      }).toList();

                    },
                  ),

                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only( left: 12, bottom: 5 ),
                  child: Text(
                    FlutterI18n.translate(context, "fields.balance_account.label"),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                TextFormField(
                  controller: state.amountController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  // onChanged: (value) => cubit.updateValueLimitCategory(category.id, value),
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

            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 14, vertical: 12 ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  FlutterI18n.translate(context, "pages.login.register_account.type_account"),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            buildTypeAccountGrid(state.typeAccounts),

            DefaultButton(
              function: () => cubit.validateAndRegisterAccount(),
              text: "shared.btn_continue",
            ),

          ],
        ),
      ),
    );
  }
}
