import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class DefaultButton extends StatelessWidget {
  final Function function;
  final String text;
  const DefaultButton({ super.key, required this.function, required this.text });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Column(
      children: [

        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => function.call(),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                FlutterI18n.translate(context, text),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.scaffoldBackgroundColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

      ],
    );
  }
}
