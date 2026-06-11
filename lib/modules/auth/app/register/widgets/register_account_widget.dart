import 'package:flutter/material.dart';
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
    final defaultCoin = state.getDefaultCoin();
    
    return SingleChildScrollView(
      child: Form(
        key: Session.formKey,
        child: Column(
          children: [

            RegisterHeaderWidget(
              step: 4,
              title: "pages.login.register_account.welcome",
              subtitle: "pages.login.register_account.subtitle",
            ),

          ],
        ),
      ),
    );
  }
}
