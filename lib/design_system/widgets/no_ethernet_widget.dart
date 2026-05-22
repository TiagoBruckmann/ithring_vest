import "dart:async";
import "package:flutter/material.dart";
import "package:flutter_i18n/flutter_i18n.dart";

class NoEthernetWidget extends StatelessWidget {
  const NoEthernetWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final statusNotifier = ValueNotifier<bool>(true);
    final opacityNotifier = ValueNotifier<double>(1);

    void changeStatus() {
      Timer.periodic(const Duration(seconds: 3), (Timer t) {
        if ( opacityNotifier.value == 0 ) {
          statusNotifier.value = !statusNotifier.value;
          opacityNotifier.value = 1;
        } else {
          opacityNotifier.value = 0;
        }
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      changeStatus();
    });

    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder<double>(
          valueListenable: opacityNotifier,
          builder: (context, opacity, _) {

            return ValueListenableBuilder<bool>(
              valueListenable: statusNotifier,
              builder: (context, status, _) {

                return AnimatedContainer(
                  padding: const EdgeInsets.only( top: 20, bottom: 100 ),
                  alignment: Alignment.center,
                  duration: const Duration(seconds: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      AnimatedOpacity(
                        duration: const Duration(seconds: 2),
                        opacity: opacity,
                        child: SizedBox(
                          height: 50,
                          child: Icon(
                            ( status )
                              ? Icons.wifi
                              : Icons.wifi_off,
                            size: 80,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(22, 60, 22, 10),
                        child: Text(
                          FlutterI18n.translate(context, "pages.connection.title"),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(22, 0, 22, 10),
                        child: Text(
                          FlutterI18n.translate(context, "pages.connection.subheading"),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),

                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
