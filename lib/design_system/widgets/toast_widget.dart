import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:ithring_vest/session.dart';
import 'package:overlay_support/overlay_support.dart';

class ToastWidget {
  final String message;
  final IconData icon;
  final int seconds;
  final Color iconColor;
  final Color textColor;
  final Color? backgroundColor;
  final String? subtitle;
  final Map<String, String>? titleTranslationParams;
  final Map<String, String>? subtitleTranslationParams;
  ToastWidget( this.message, this.icon, this.seconds, { this.iconColor = Colors.white, this.textColor = Colors.white, this.backgroundColor, this.subtitle, this.titleTranslationParams, this.subtitleTranslationParams });

  void showToastWidget() {
    showOverlayNotification(( widget ) => _notificationDialog(),
      duration: Duration(seconds: seconds),
    );
  }

  Widget _notificationDialog() {
    return SafeArea(
      child: Builder(
        builder: (context) {

          final theme = Theme.of(context);

          return GestureDetector(
            onTap: () => OverlaySupportEntry.of(context)!.dismiss(),
            onVerticalDragEnd: ( details ) {
              if ( details.primaryVelocity! < 0 ) {
                OverlaySupportEntry.of(context)!.dismiss();
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric( horizontal: 16, vertical: 12 ),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: backgroundColor ?? theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.fromBorderSide(
                  BorderSide(
                    color: backgroundColor ?? theme.scaffoldBackgroundColor,
                  ),
                ),
              ),
              child: Column(
                children: [

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only( right: 10 ),
                        child: Icon(
                          icon,
                          color: iconColor,
                        ),
                      ),

                      Expanded(
                        child: Text(
                          FlutterI18n.translate(context, message, translationParams: titleTranslationParams),
                          style: TextStyle(
                            color: textColor,
                          ),
                        ),
                      ),

                    ],
                  ),

                  if ( subtitle != null )
                    Padding(
                      padding: const EdgeInsets.only( top: 10 ),
                      child: Row(
                        children: [

                          Expanded(
                            child: Text(
                              FlutterI18n.translate(context, subtitle!, translationParams: subtitleTranslationParams),
                              style: TextStyle(
                                color: textColor,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),

                ],
              ),
            ),
          );

        },
      ),
    );
  }

}

void showSuccess( String message, { int seconds = 4, String? subtitle, Map<String, String>? titleTranslationParams, Map<String, String>? subtitleTranslationParams }) {
  return ToastWidget(
    message,
    Icons.check_circle_outline,
    seconds,
    backgroundColor: Theme.of(Session.globalContext.currentContext!).colorScheme.onSecondary,
    subtitle: subtitle,
    titleTranslationParams: titleTranslationParams,
    subtitleTranslationParams: subtitleTranslationParams,
    textColor: Theme.of(Session.globalContext.currentContext!).scaffoldBackgroundColor,
  ).showToastWidget();
}

void showError( String message, { int seconds = 4, String? subtitle, Map<String, String>? titleTranslationParams, Map<String, String>? subtitleTranslationParams }) {
  return ToastWidget(
    message,
    Icons.error_outline,
    seconds,
    backgroundColor: Theme.of(Session.globalContext.currentContext!).colorScheme.error,
    subtitle: subtitle,
    titleTranslationParams: titleTranslationParams,
    subtitleTranslationParams: subtitleTranslationParams,
  ).showToastWidget();
}

void showWarning( String message, { int seconds = 4, String? subtitle, Map<String, String>? titleTranslationParams, Map<String, String>? subtitleTranslationParams }) {
  return ToastWidget(
    message,
    Icons.warning_amber_outlined,
    seconds,
    backgroundColor: Theme.of(Session.globalContext.currentContext!).colorScheme.onTertiary,
    subtitle: subtitle,
    titleTranslationParams: titleTranslationParams,
    subtitleTranslationParams: subtitleTranslationParams,
  ).showToastWidget();
}

void showInfo( String message, { int seconds = 4, String? subtitle, Map<String, String>? titleTranslationParams, Map<String, String>? subtitleTranslationParams }) {
  return ToastWidget(
    message,
    Icons.info_outline,
    seconds,
    backgroundColor: Theme.of(Session.globalContext.currentContext!).colorScheme.inversePrimary,
    subtitle: subtitle,
    titleTranslationParams: titleTranslationParams,
    subtitleTranslationParams: subtitleTranslationParams,
  ).showToastWidget();
}
