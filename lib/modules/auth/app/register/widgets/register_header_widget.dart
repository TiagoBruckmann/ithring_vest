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
