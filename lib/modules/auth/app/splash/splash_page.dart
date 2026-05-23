import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:ithring_vest/core/domain/source/local/injection/injection.dart';
import 'package:ithring_vest/design_system/widgets/ithring_vest_widget.dart';
import 'package:ithring_vest/modules/auth/app/splash/cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    final theme = Theme.of(context);

    return Scaffold(
      body: BlocProvider(
        create: (create) => getIt<SplashCubit>(),
        child: BlocBuilder<SplashCubit, SplashCubitState>(
          builder: ( builder, state ) {

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.only( top: 20 ),
                  child: IthringVestWidget(),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric( horizontal: 10 ),
                  child: Row(
                    children: [

                      Expanded(
                        child: Divider(
                          color: theme.primaryColorDark,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "⧫",
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.primaryColorDark,
                          ),
                        ),
                      ),

                      Expanded(
                        child: Divider(
                          color: theme.primaryColorDark,
                        ),
                      ),

                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only( top: 20 ),
                  child: Text.rich(
                    TextSpan(
                      text: FlutterI18n.translate(context, "pages.splash.title1"),
                      style: theme.textTheme.titleLarge,
                      children: [

                        TextSpan(
                          text: FlutterI18n.translate(context, "pages.splash.title2"),
                          style: theme.textTheme.titleLarge!.apply(
                            color: theme.primaryColorDark,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            );

          },
        ),
      ),
    );
  }
}
