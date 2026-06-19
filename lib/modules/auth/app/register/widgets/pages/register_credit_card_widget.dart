import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:ithring_vest/design_system/widgets/default_button.dart';
import 'package:ithring_vest/modules/auth/app/register/cubit/register_cubit.dart';
import 'package:ithring_vest/modules/auth/app/register/widgets/register_header_widget.dart';
import 'package:ithring_vest/session.dart';

class RegisterCreditCardWidget extends StatelessWidget {
  final RegisterCubit cubit;
  final RegisterCardState state;
  const RegisterCreditCardWidget({ super.key, required this.cubit, required this.state });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Form(
        key: Session.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            RegisterHeaderWidget(
              step: 5,
              title: "pages.login.register_card.welcome",
              subtitle: "pages.login.register_card.subtitle",
            ),

            Padding(
              padding: const EdgeInsets.only( left: 12, bottom: 5 ),
              child: Text(
                FlutterI18n.translate(context, "fields.card_name.label"),
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
              validator: (value) => Session.fieldsValidation.validateCardName(value ?? ""),
              decoration: InputDecoration(
                hintText: FlutterI18n.translate(context, "fields.card_name.hint"),
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

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only( left: 12, bottom: 5 ),
                  child: Text(
                    FlutterI18n.translate(context, "fields.credit_card_limit.label"),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                TextFormField(
                  controller: state.limitController,
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

            DefaultButton(
              function: () => cubit.validateAndRegisterAccount(),
              text: "pages.login.register_card.btn",
            ),

          ],
        ),
      ),
    );
  }
}
