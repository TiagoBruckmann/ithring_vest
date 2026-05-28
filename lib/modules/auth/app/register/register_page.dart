import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithring_vest/core/domain/source/local/injection/injection.dart';
import 'package:ithring_vest/design_system/widgets/verify_connection_widget.dart';
import 'package:ithring_vest/modules/auth/app/register/cubit/register_cubit.dart';
import 'package:ithring_vest/modules/auth/app/register/widgets/register_user_category_widget.dart';
import 'package:ithring_vest/modules/auth/app/register/widgets/register_user_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (create) => getIt<RegisterCubit>(),
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: ( builder, state ) {

          final cubit = BlocProvider.of<RegisterCubit>(builder);

          return VerifyConnectionWidget(
            isLoading: state is RegisterLoadingState,
            keyAppBar: "pages.login.register.app_bar",
            child: ( state is RegisterCredentialState )
            ? RegisterUserWidget(cubit: cubit, state: state)
            : ( state is RegisterCategoriesState )
            ? RegisterUserCategoryWidget(cubit: cubit, state: state)
            : ( state is RegisterAccountsState )
            ? Container()
            : Container(),
          );
        },
      ),
    );
  }
}
