import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class LoadingOverlayWidget extends StatelessWidget {
  final Widget child;
  final String message;
  final bool isLoading;
  const LoadingOverlayWidget({super.key, required this.child, this.message = "", this.isLoading = false});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Stack(
      children: [
        child,

        if ( isLoading )
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.black.withValues(alpha: 0.7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const CircularProgressIndicator(),

                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    FlutterI18n.translate(context, message),
                    style: theme.textTheme.bodyMedium?.apply(
                      color: theme.scaffoldBackgroundColor,
                    ),
                  ),
                ),

              ],
            ),
          ),

      ],
    );
  }
}