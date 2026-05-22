import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:ithring_vest/core/domain/source/local/injection/injection.dart';
import 'package:ithring_vest/core/domain/source/local/mobx/connection/connection_mobx.dart';
import 'package:ithring_vest/design_system/widgets/loading_overlay_widget.dart';
import 'package:ithring_vest/design_system/widgets/no_ethernet_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ithring_vest/session.dart';

class VerifyConnectionWidget extends StatelessWidget {
  final String keyAppBar;
  final Map<String, String>? appBarParams;
  final List<Widget>? actionWidgets;
  final double bodyPadding;
  final Color? titleColor;
  final Widget body;
  final Widget? drawer;
  final bool canPop;
  final Function? popFunction;
  final bool isLoading;
  final String loadingMessage;
  final Widget? bottomNavigationBar;
  const VerifyConnectionWidget({ super.key, this.keyAppBar = "", this.appBarParams, this.actionWidgets, this.bodyPadding = 16, this.titleColor, required this.body, this.drawer, this.canPop = true, this.popFunction, this.isLoading = false, this.loadingMessage = "", this.bottomNavigationBar });

  @override
  Widget build(BuildContext context) {

    final connectionMobx = getIt<ConnectionMobx>();
    connectionMobx.listenChangeConnectivityState();
    final ThemeData theme = Theme.of(context);

    return Observer(
      builder: (builder) {

        return SafeArea(
          child: PopScope(
            canPop: canPop,
            onPopInvokedWithResult: ( canPop, object ) async {
              if ( canPop == false && popFunction != null ) {
                return await popFunction!.call();
              }

              if ( !isLoading && canPop == false ) {
                Session.navigation.pop();
              }

              if ( canPop && popFunction != null ) {
                return await popFunction!.call();
              }

            },
            child: LoadingOverlayWidget(
              isLoading: isLoading,
              message: loadingMessage,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    FlutterI18n.translate(context, keyAppBar, translationParams: appBarParams),
                    style: theme.appBarTheme.titleTextStyle!.copyWith(
                      color: titleColor,
                    ),
                  ),
                  actions: actionWidgets ?? [],
                ),
                drawer: drawer,
                body: ( !connectionMobx.isValidConnection )
                    ? const NoEthernetWidget()
                    : Padding(
                  padding: EdgeInsets.all(bodyPadding),
                  child: body,
                ),
                bottomNavigationBar: ( !connectionMobx.isValidConnection )
                    ? null
                    : bottomNavigationBar,
              ),
            ),
          ),
        );

      },
    );
  }
}