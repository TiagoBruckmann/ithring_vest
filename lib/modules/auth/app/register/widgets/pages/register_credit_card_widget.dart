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

            ListTile(
              onTap: () => cubit.skipCreditCard(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: theme.colorScheme.tertiary.withValues(alpha: 0.3),
                ),
              ),
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.tertiary,
                child: Icon(
                  Icons.keyboard_double_arrow_right,
                  size: 20,
                ),
              ),
              title: Text(
                FlutterI18n.translate(context, "pages.login.register_card.skip_title"),
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Text(
                FlutterI18n.translate(context, "pages.login.register_card.skip_subtitle"),
                style: theme.textTheme.bodyMedium,
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 20,
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB( 12, 12, 0, 5 ),
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

            Padding(
              padding: const EdgeInsets.fromLTRB( 12, 12, 0, 5 ),
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

            Padding(
              padding: const EdgeInsets.fromLTRB( 12, 12, 0, 5 ),
              child: Text(
                FlutterI18n.translate(context, "fields.linked_account.label"),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Card(
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
                      state.account.name,
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

            DefaultButton(
              function: () => cubit.validateAndRegisterCard(),
              text: "pages.login.register_card.btn",
            ),

          ],
        ),
      ),
    );
  }
}
