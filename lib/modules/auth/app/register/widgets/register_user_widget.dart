import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:ithring_vest/core/domain/entities/coin_entity.dart';
import 'package:ithring_vest/modules/auth/app/register/cubit/register_cubit.dart';
import 'package:ithring_vest/session.dart';

class RegisterUserWidget extends StatelessWidget {
  final RegisterCubit cubit;
  final RegisterCredentialState state;
  const RegisterUserWidget({ super.key, required this.cubit, required this.state });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    Widget buildCurrencyButton( CoinEntity coin, CoinEntity selectedCoin ) {
      final isSelected = selectedCoin.acronym == coin.acronym;

      return OutlinedButton(
        onPressed: () => cubit.selectCoin(coin),
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? theme.primaryColor : null,
          side: BorderSide(
            color: isSelected
              ? theme.primaryColor
              : theme.colorScheme.tertiary.withValues(alpha: 0.3),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Text(
              coin.symbol,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected
                    ? theme.scaffoldBackgroundColor
                    : theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              coin.acronym,
              style: theme.textTheme.labelSmall?.copyWith(
                color: isSelected
                    ? theme.scaffoldBackgroundColor
                    : theme.colorScheme.tertiary,
              ),
            ),

          ],
        ),
      );
    }

    Widget buildValidationItem( String text, bool isValid ) {
      return Row(
        children: [

          Icon(
            isValid ? Icons.check_circle : Icons.circle_outlined,
            size: 20,
            color: isValid ? theme.primaryColor : theme.colorScheme.tertiary,
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isValid ? theme.primaryColor : theme.colorScheme.tertiary,
              ),
            ),
          ),

        ],
      );
    }

    Widget buildPasswordValidation( String password ) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          buildValidationItem(
            FlutterI18n.translate(context, "pages.login.register.at_least_8_characters"),
            Session.fieldsValidation.isPasswordValidLength(password),
          ),

          const SizedBox(height: 8),

          buildValidationItem(
            FlutterI18n.translate(context, "pages.login.register.include_letter_and_number"),
            Session.fieldsValidation.hasNumber(password),
          ),

          const SizedBox(height: 8),

          buildValidationItem(
            FlutterI18n.translate(context, "pages.login.register.include_special_character"),
            Session.fieldsValidation.isValidPassword(password),
          ),

        ],
      );
    }
    
    return SingleChildScrollView(
      child: Form(
        key: state.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            LinearProgressIndicator(
              value: 0.25,
              minHeight: 4,
              backgroundColor:
              theme.colorScheme.tertiary.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.primaryColor,
              ),
            ),

            const SizedBox(height: 32),

            Text(
              FlutterI18n.translate(
                context,
                "pages.login.register.welcome_title",
              ),
              style: theme.textTheme.headlineSmall,
            ),

            const SizedBox(height: 12),

            Text(
              FlutterI18n.translate(
                context,
                "pages.login.register.subtitle",
              ),
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.5,
              ),
            ),

            const SizedBox(height: 32),

            Text(
              FlutterI18n.translate(context, "fields.name.label"),
              style: theme.textTheme.labelMedium,
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: state.nameController,
              keyboardType: TextInputType.name,
              validator: (value) => Session.fieldsValidation.validateName(value ?? ""),
              decoration: InputDecoration(
                hintText: FlutterI18n.translate(
                  context,
                  "fields.name.hint",
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.person_outline,
                    color: theme.colorScheme.tertiary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              FlutterI18n.translate(
                context,
                "pages.login.register.primary_currency",
              ),
              style: theme.textTheme.labelMedium,
            ),

            const SizedBox(height: 8),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [

                  for ( final coin in cubit.coins )
                    Padding(
                      padding: const EdgeInsets.only( right: 12 ),
                      child: buildCurrencyButton(
                        coin,
                        state.defaultCoin,
                      ),
                    ),

                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              FlutterI18n.translate(context, "fields.email.label"),
              style: theme.textTheme.labelMedium,
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: state.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => Session.fieldsValidation.validateEmail(value ?? ""),
              decoration: InputDecoration(
                hintText: FlutterI18n.translate(
                  context,
                  "fields.email.hint",
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.mail_outline,
                    color: theme.colorScheme.tertiary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              FlutterI18n.translate(context, "fields.password.label"),
              style: theme.textTheme.labelMedium,
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: state.passwordController,
              obscureText: state.obscurePassword,
              onChanged: (value) => cubit.validatePwd(value),
              validator: (value) => Session.fieldsValidation.validatePassword(value ?? ""),
              decoration: InputDecoration(
                hintText: FlutterI18n.translate(
                  context,
                  "fields.password.hint",
                ),
                suffixIcon: GestureDetector(
                  onTap: () => cubit.togglePwdVisibility(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(
                      state.obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                      color: theme.colorScheme.tertiary,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              FlutterI18n.translate(context, "fields.password.confirm_password"),
              style: theme.textTheme.labelMedium,
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: state.confirmPasswordController,
              obscureText: state.obscureConfirmPassword,
              onChanged: (value) => cubit.validateConfirmPwd(value),
              validator: (value) => Session.fieldsValidation.validatePassword(state.passwordController.text, isConfirm: true, confirmPassword: value ?? ""),
              decoration: InputDecoration(
                hintText: FlutterI18n.translate(
                  context,
                  "fields.password.hint",
                ),
                suffixIcon: GestureDetector(
                  onTap: () => cubit.toggleConfirmPwdVisibility(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(
                      state.obscureConfirmPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                      color: theme.colorScheme.tertiary,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            buildPasswordValidation(
              state.passwordController.text,
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => cubit.validateCredentialsFields(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  FlutterI18n.translate(context, "shared.continue"),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.scaffoldBackgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
