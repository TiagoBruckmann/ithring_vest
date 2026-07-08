import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class RegisterHeaderWidget extends StatelessWidget {
  final int step;
  final String title;
  final String subtitle;
  const RegisterHeaderWidget({ super.key, required this.step, required this.title, required this.subtitle });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            for ( int i = 0; i < step; i++ ) ...[

              CircleAvatar(
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(
                    "${i+1}",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.scaffoldBackgroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              if ( i < step - 1 )
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric( horizontal: 5 ),
                    child: Divider(
                      color: theme.primaryColorDark,
                    ),
                  ),
                ),

            ],

          ],
        ),

        const SizedBox(height: 32),

        Text(
          FlutterI18n.translate(context, title),
          style: theme.textTheme.headlineSmall,
        ),

        const SizedBox(height: 12),

        Text(
          FlutterI18n.translate(context, subtitle),
          style: theme.textTheme.bodyMedium?.copyWith(
            height: 1.5,
          ),
        ),

        const SizedBox(height: 24),

      ],
    );
  }
}
