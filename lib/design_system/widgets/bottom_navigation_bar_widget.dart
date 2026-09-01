import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  const BottomNavigationBarWidget({ super.key, this.selectedIndex = 0 });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    Widget buildNavItem({
      required int index,
      required IconData icon,
      required IconData activeIcon,
      required String label,
    }) {
      final isSelected = selectedIndex == index;
      final activeColor = theme.primaryColor;
      final inactiveColor = theme.colorScheme.onSurface;

      return Expanded(
        child: InkWell(
          onTap: () {
            /*
            if ( index == 0 ) {
              Session.navigatorKey.currentState?.pushNamed("/accounts");
            }
            */
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Icon(
                ( isSelected ) ? activeIcon : icon,
                color: ( isSelected ) ? activeColor : inactiveColor,
                size: 24,
              ),

              const SizedBox(height: 4),

              Text(
                FlutterI18n.translate(context, "shared.bottom_bar.$label"),
                style: theme.textTheme.labelMedium!.apply(
                  color: ( isSelected ) ? activeColor : inactiveColor,
                ),
              ),

            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: const Border(
          top: BorderSide(
            color: Color(0xFF1E2630), // Borda superior sutil
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              buildNavItem(
                index: 0,
                icon: Icons.home_outlined,
                activeIcon: Icons.home_rounded,
                label: "home",
              ),

              buildNavItem(
                index: 1,
                icon: Icons.pie_chart_outline_rounded,
                activeIcon: Icons.pie_chart_rounded,
                label: "analysis",
              ),

              buildNavItem(
                index: 2,
                icon: Icons.add_circle_outline,
                activeIcon: Icons.add_circle,
                label: "release",
              ),

              buildNavItem(
                index: 3,
                icon: Icons.account_balance_wallet_outlined,
                activeIcon: Icons.account_balance_wallet_rounded,
                label: "wallet",
              ),

              buildNavItem(
                index: 4,
                icon: Icons.category_outlined,
                activeIcon: Icons.category,
                label: "categories",
              ),

            ],
          ),
        ),
      ),
    );
  }
}
