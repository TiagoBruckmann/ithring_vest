import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:ithring_vest/session.dart';

Future<dynamic> showCustomDialog( Widget widget ) async {
  return await showDialog(
    context: Session.globalContext.currentContext!,
    barrierDismissible: false,
    builder: ( builder ) => widget,
  );
}

Widget showDefaultDialog({
  required String title,
  required Widget body,
  TextStyle? titleTextStyle,
  Color? buttonColor,
  Color? cancelTextColor,
  String? textCancel,
  String? textConfirm,
  Color? confirmTextColor,
  Function? confirmFunction,
  Function? cancelFunction,
  double horizontalPadding = 10 }) {

  final builder = Session.globalContext.currentContext!;
  final theme = Theme.of(builder);

  return AlertDialog(
    titlePadding: EdgeInsets.fromLTRB(horizontalPadding, 5, horizontalPadding, 0),
    contentPadding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 10),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Text(
          FlutterI18n.translate(builder, title),
          textAlign: TextAlign.center,
          style: titleTextStyle ?? theme.textTheme.titleMedium,
        ),

        IconButton(
          onPressed: () => Session.navigation.pop(),
          icon: Icon(
            Icons.close,
          ),
        ),

      ],
    ),
    content: body,
    actionsAlignment: MainAxisAlignment.end,
    actions: ( (textCancel != null && textConfirm != null ) && ( textCancel.trim().isEmpty && textConfirm.trim().isEmpty ) )
        ? null
        : [

      TextButton(
        onPressed: () {
          Session.navigation.pop();

          if ( cancelFunction != null ) {
            cancelFunction.call();
            return;
          }

        },
        style: TextButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        ),
        child: Text(
          FlutterI18n.translate(builder, textCancel ?? "btn_cancel"),
          style: theme.textTheme.bodySmall!.copyWith(
            color: cancelTextColor ?? theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      TextButton(
        onPressed: () {
          Session.navigation.pop();

          if ( confirmFunction != null ) {
            confirmFunction.call();
            return;
          }
        },
        style: TextButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        ),
        child: Text(
          FlutterI18n.translate(builder, textConfirm ?? "btn_confirm"),
          style: theme.textTheme.bodySmall!.copyWith(
            color: cancelTextColor ?? theme.colorScheme.onInverseSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

    ],
  );
}

void showLoadingDialog( String message ) {
  showCustomDialog(
    Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(message),
      ),
    ),
  );
}