import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:ithring_vest/core/domain/source/local/injection/injection.dart';
import 'package:ithring_vest/design_system/widgets/ithring_vest_widget.dart';
import 'package:ithring_vest/design_system/widgets/verify_connection_widget.dart';
import 'package:ithring_vest/modules/auth/app/login/cubit/login_cubit.dart';
import 'package:ithring_vest/modules/auth/routes/auth_path.dart';
import 'package:ithring_vest/session.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return BlocProvider(
      create: (create) => getIt<LoginCubit>(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: ( builder, state ) {

          final cubit = BlocProvider.of<LoginCubit>(builder);
          final obscurePassword = (state is LoginInitialState) ? state.obscurePassword : true;
          final rememberMe = (state is LoginInitialState) ? state.rememberMe : true;

          return VerifyConnectionWidget(
            isLoading: state is LoginLoadingState,
            child: SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 40),

                    Center(
                      child: const IthringVestWidget(),
                    ),

                    const SizedBox(height: 40),

                    Text(
                      FlutterI18n.translate(context, "pages.login.login.welcome"),
                      style: theme.textTheme.headlineSmall,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      FlutterI18n.translate(context, "pages.login.login.subtitle"),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 32),

                    TextFormField(
                      controller: cubit.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => Session.fieldsValidation.validateEmail(value ?? ""),
                      decoration: InputDecoration(
                        labelText: FlutterI18n.translate(context, "fields.email.label"),
                        hintText: FlutterI18n.translate(context, "fields.email.hint"),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.mail_outline,
                            color: theme.colorScheme.tertiary,
                          ),
                        ),
                      ),
                      style: theme.textTheme.bodyLarge,
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      controller: cubit.passwordController,
                      obscureText: obscurePassword,
                      validator: (value) => Session.fieldsValidation.validatePassword(value ?? ""),
                      decoration: InputDecoration(
                        labelText: FlutterI18n.translate(context, "fields.password.label"),
                        hintText: FlutterI18n.translate(context, "fields.password.hint"),
                        suffixIcon: GestureDetector(
                          onTap: () => cubit.togglePwdVisibility(),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(
                              obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                              color: theme.colorScheme.tertiary,
                            ),
                          ),
                        ),
                      ),
                      style: theme.textTheme.bodyLarge,
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(
                          children: [

                            Checkbox(
                              value: rememberMe,
                              onChanged: (value) => cubit.toggleRemember(value ?? false),
                            ),

                            Text(
                              FlutterI18n.translate(context, "pages.login.login.remember_me"),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),

                          ],
                        ),

                        GestureDetector(
                          onTap: () { },
                          child: Text(
                            FlutterI18n.translate(context, "pages.login.login.forgot_password"),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                      ],
                    ),

                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => cubit.validateFields(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                        ),
                        child: Text(
                          FlutterI18n.translate(context, "pages.login.login.enter_button"),
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.scaffoldBackgroundColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Row(
                      children: [

                        Expanded(
                          child: Divider(
                            color: theme.colorScheme.tertiary.withValues(alpha: 0.3),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            FlutterI18n.translate(context, "pages.login.login.continue_with"),
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.tertiary,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Divider(
                            color: theme.colorScheme.tertiary.withValues(alpha: 0.3),
                          ),
                        ),

                      ],
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () async => await cubit.signInWithGoogle(),
                        icon: FaIcon(
                          FontAwesomeIcons.google,
                          color: theme.colorScheme.onPrimary,
                          size: 20,
                        ),
                        label: Text(
                          FlutterI18n.translate(context, "pages.login.login.google"),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(
                            color: theme.colorScheme.tertiary.withValues(alpha: 0.3),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    GestureDetector(
                      onTap: () => Session.navigation.push(AuthPath.registerPath.register),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            text: FlutterI18n.translate(context, "pages.login.login.no_account"),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                            children: [

                              TextSpan(
                                text: FlutterI18n.translate(context, "pages.login.login.create_account"),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                  ],
                ),
              ),
            ),
          );

        },
      ),
    );
  }
}