import 'package:flutter/material.dart';
import 'package:ithring_vest/design_system/style/app_images.dart';

class IthringVestWidget extends StatelessWidget {
  const IthringVestWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Image.asset(
      ( theme.brightness == Brightness.dark )
          ? AppImages.logoAndTitleDarkMode
          : AppImages.logoAndTitleLightMode,
      height: 70,
    );
  }
}
