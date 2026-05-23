import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ithring_vest/design_system/style/theme/app_colors_dark.dart';
import 'package:ithring_vest/design_system/style/theme/app_colors_light.dart';

class Themes {
  Themes._();

  // .****************
  // Theme - DARK
  // .****************
  static final _colorSchemeDark = ColorScheme.dark(
    primary: AppColorsDark.primaryGreen,
    secondary: AppColorsDark.primaryPurple,
    surface: AppColorsDark.cardsBackground,
    error: AppColorsDark.error,
    onPrimary: AppColorsDark.primaryText,
    onSecondary: AppColorsDark.hoverGreen,
    onSurface: AppColorsDark.secondaryText,
    tertiary: AppColorsDark.tertiaryText,
    // onError: AppColorsDark.primaryText,
    brightness: Brightness.dark,
  );

  static final _textThemeDark = TextTheme(
    headlineLarge: GoogleFonts.playfairDisplay(
      color: AppColorsDark.primaryText,
      fontWeight: FontWeight.bold,
      fontSize: 32,
      height: 1.1,
    ),
    headlineMedium: GoogleFonts.playfairDisplay(
      color: AppColorsDark.primaryText,
      fontWeight: FontWeight.bold,
      fontSize: 26,
    ),
    headlineSmall: GoogleFonts.playfairDisplay(
      color: AppColorsDark.primaryText,
      fontWeight: FontWeight.w700,
      fontSize: 22,
    ),
    titleLarge: GoogleFonts.playfairDisplay(
      color: AppColorsDark.primaryText,
      fontWeight: FontWeight.w700,
      fontSize: 18,
    ),
    titleMedium: GoogleFonts.playfairDisplay(
      color: AppColorsDark.primaryText,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    titleSmall: GoogleFonts.playfairDisplay(
      color: AppColorsDark.secondaryText,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
    bodyLarge: GoogleFonts.playfairDisplay(
      color: AppColorsDark.primaryText,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    bodyMedium: GoogleFonts.playfairDisplay(
      color: AppColorsDark.secondaryText,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    bodySmall: GoogleFonts.playfairDisplay(
      color: AppColorsDark.tertiaryText,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    labelLarge: GoogleFonts.playfairDisplay(
      color: AppColorsDark.primaryText,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
    labelMedium: GoogleFonts.playfairDisplay(
      color: AppColorsDark.secondaryText,
      fontWeight: FontWeight.w500,
      fontSize: 12,
    ),
    labelSmall: GoogleFonts.playfairDisplay(
      color: AppColorsDark.tertiaryText,
      fontWeight: FontWeight.w500,
      fontSize: 11,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColorsDark.primaryBackground,
    colorScheme: _colorSchemeDark,
    primaryColor: AppColorsDark.primaryGreen,
    primaryColorDark: AppColorsDark.darkGreen,
    primaryColorLight: AppColorsDark.lightGreen,
    canvasColor: AppColorsDark.secondaryBackground,
    dividerColor: AppColorsDark.tertiaryText.withValues(alpha: 0.12),
    splashColor: AppColorsDark.primaryGreen.withValues(alpha: 0.08),
    highlightColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColorsDark.primaryBackground,
      foregroundColor: AppColorsDark.primaryText,
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: AppColorsDark.primaryText,
      ),
      titleTextStyle: TextStyle(
        color: AppColorsDark.primaryText,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColorsDark.cardsBackground,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: Colors.white.withValues(alpha: 0.04),
        ),
      ),
      margin: EdgeInsets.zero,
    ),
    textTheme: _textThemeDark,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColorsDark.primaryGreen,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorsDark.secondaryBackground,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),
      hintStyle: const TextStyle(
        color: AppColorsDark.tertiaryText,
        fontWeight: FontWeight.w400,
      ),
      labelStyle: const TextStyle(
        color: AppColorsDark.secondaryText,
      ),
      floatingLabelStyle: const TextStyle(
        color: AppColorsDark.primaryGreen,
        fontWeight: FontWeight.w600,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: Colors.white.withValues(alpha: 0.06),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: Colors.white.withValues(alpha: 0.06),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: AppColorsDark.primaryGreen,
          width: 1.4,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: AppColorsDark.error,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: AppColorsDark.error,
          width: 1.4,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColorsDark.primaryGreen,
        foregroundColor: AppColorsDark.primaryBackground,
        disabledBackgroundColor:
        AppColorsDark.unableText.withValues(alpha: 0.2),
        disabledForegroundColor: AppColorsDark.unableText,
        elevation: 0,
        shadowColor: Colors.transparent,
        minimumSize: const Size(double.infinity, 58),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColorsDark.primaryText,
        minimumSize: const Size(double.infinity, 58),
        side: BorderSide(
          color: Colors.white.withValues(alpha: 0.08),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (states) {
          if ( states.contains(WidgetState.selected) ) {
            return AppColorsDark.primaryGreen;
          }

          return AppColorsDark.unableText;
        },
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (states) {
          if ( states.contains(WidgetState.selected) ) {
            return AppColorsDark.primaryGreen.withValues(alpha: 0.35);
          }

          return AppColorsDark.secondaryBackground;
        },
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) {
          if ( states.contains(WidgetState.selected) ) {
            return AppColorsDark.primaryGreen;
          }

          return Colors.transparent;
        },
      ),
      checkColor: WidgetStateProperty.all(
        AppColorsDark.primaryBackground,
      ),
      side: BorderSide(
        color: Colors.white.withValues(alpha: 0.12),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColorsDark.secondaryBackground,
      selectedColor: AppColorsDark.primaryGreen.withValues(alpha: 0.12),
      disabledColor: AppColorsDark.unableText.withValues(alpha: 0.08),
      secondarySelectedColor:
      AppColorsDark.primaryGreen.withValues(alpha: 0.12),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      labelStyle: const TextStyle(
        color: AppColorsDark.secondaryText,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: const TextStyle(
        color: AppColorsDark.primaryGreen,
        fontWeight: FontWeight.w600,
      ),
      brightness: Brightness.dark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: Colors.white.withValues(alpha: 0.04),
        ),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColorsDark.elevatedCardBackground,
      contentTextStyle: const TextStyle(
        color: AppColorsDark.primaryText,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      behavior: SnackBarBehavior.floating,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColorsDark.cardsBackground,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColorsDark.primaryGreen,
      linearTrackColor: AppColorsDark.secondaryBackground,
      circularTrackColor: AppColorsDark.secondaryBackground,
    ),
    iconTheme: const IconThemeData(
      color: AppColorsDark.primaryText,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: AppColorsDark.secondaryText,
      textColor: AppColorsDark.primaryText,
      tileColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColorsDark.cardsBackground,
      surfaceTintColor: Colors.transparent,
      modalBackgroundColor: AppColorsDark.cardsBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColorsDark.navBarTabBarBackground,
      selectedItemColor: AppColorsDark.primaryGreen,
      unselectedItemColor: AppColorsDark.tertiaryText,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColorsDark.navBarTabBarBackground,
      indicatorColor: AppColorsDark.primaryGreen.withValues(alpha: 0.14),
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) {
          final selected = states.contains(WidgetState.selected);

          return TextStyle(
            color: ( selected )
              ? AppColorsDark.primaryGreen
              : AppColorsDark.tertiaryText,
            fontWeight: ( selected )
              ? FontWeight.w600
              : FontWeight.w500,
            fontSize: 12,
          );
        },
      ),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) {
          final selected = states.contains(WidgetState.selected);

          return IconThemeData(
            color: ( selected )
              ? AppColorsDark.primaryGreen
              : AppColorsDark.tertiaryText,
          );
        },
      ),
    ),
  );

  // .****************
  // Theme - LIGHT
  // .****************
  static final _colorSchemeLight = ColorScheme.light(
    primary: AppColorsLight.primaryGreen,
    secondary: AppColorsLight.primaryPurple,
    surface: AppColorsLight.cardsBackground,
    error: AppColorsLight.error,
    onPrimary: AppColorsLight.primaryText,
    onSecondary: AppColorsLight.primaryText,
    onSurface: AppColorsLight.primaryText,
    onError: AppColorsLight.primaryText,
    brightness: Brightness.light,
  );

  static final _textThemeLight = TextTheme(
    headlineLarge: GoogleFonts.playfairDisplay(
      color: AppColorsLight.primaryText,
      fontWeight: FontWeight.bold,
      fontSize: 32,
      height: 1.1,
    ),
    headlineMedium: GoogleFonts.playfairDisplay(
      color: AppColorsLight.primaryText,
      fontWeight: FontWeight.bold,
      fontSize: 26,
    ),
    headlineSmall: GoogleFonts.playfairDisplay(
      color: AppColorsLight.primaryText,
      fontWeight: FontWeight.w700,
      fontSize: 22,
    ),
    titleLarge: GoogleFonts.playfairDisplay(
      color: AppColorsLight.primaryText,
      fontWeight: FontWeight.w700,
      fontSize: 18,
    ),
    titleMedium: GoogleFonts.playfairDisplay(
      color: AppColorsLight.primaryText,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    titleSmall: GoogleFonts.playfairDisplay(
      color: AppColorsLight.secondaryText,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
    bodyLarge: GoogleFonts.playfairDisplay(
      color: AppColorsLight.primaryText,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    bodyMedium: GoogleFonts.playfairDisplay(
      color: AppColorsLight.secondaryText,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    bodySmall: GoogleFonts.playfairDisplay(
      color: AppColorsLight.tertiaryText,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    labelLarge: GoogleFonts.playfairDisplay(
      color: AppColorsLight.primaryText,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
    labelMedium: GoogleFonts.playfairDisplay(
      color: AppColorsLight.secondaryText,
      fontWeight: FontWeight.w500,
      fontSize: 12,
    ),
    labelSmall: GoogleFonts.playfairDisplay(
      color: AppColorsLight.tertiaryText,
      fontWeight: FontWeight.w500,
      fontSize: 11,
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColorsLight.primaryBackground,
    colorScheme: _colorSchemeLight,
    primaryColor: AppColorsLight.primaryGreen,
    primaryColorDark: AppColorsLight.darkGreen,
    primaryColorLight: AppColorsLight.lightGreen,
    canvasColor: AppColorsLight.secondaryBackground,
    dividerColor: AppColorsLight.tertiaryText.withValues(alpha: 0.12),
    splashColor: AppColorsLight.primaryGreen.withValues(alpha: 0.08),
    highlightColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColorsLight.primaryBackground,
      foregroundColor: AppColorsLight.primaryText,
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: AppColorsLight.primaryText,
      ),
      titleTextStyle: TextStyle(
        color: AppColorsLight.primaryText,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColorsLight.cardsBackground,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: Colors.white.withValues(alpha: 0.04),
        ),
      ),
      margin: EdgeInsets.zero,
    ),
    textTheme: _textThemeLight,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColorsLight.primaryGreen,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorsLight.secondaryBackground,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),
      hintStyle: const TextStyle(
        color: AppColorsLight.tertiaryText,
        fontWeight: FontWeight.w400,
      ),
      labelStyle: const TextStyle(
        color: AppColorsLight.secondaryText,
      ),
      floatingLabelStyle: const TextStyle(
        color: AppColorsLight.primaryGreen,
        fontWeight: FontWeight.w600,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: Colors.white.withValues(alpha: 0.06),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: Colors.white.withValues(alpha: 0.06),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: AppColorsLight.primaryGreen,
          width: 1.4,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: AppColorsLight.error,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: AppColorsLight.error,
          width: 1.4,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColorsLight.primaryGreen,
        foregroundColor: AppColorsLight.primaryBackground,
        disabledBackgroundColor:
        AppColorsLight.unableText.withValues(alpha: 0.2),
        disabledForegroundColor: AppColorsLight.unableText,
        elevation: 0,
        shadowColor: Colors.transparent,
        minimumSize: const Size(double.infinity, 58),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColorsLight.primaryText,
        minimumSize: const Size(double.infinity, 58),
        side: BorderSide(
          color: Colors.white.withValues(alpha: 0.08),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
            (states) {
          if ( states.contains(WidgetState.selected) ) {
            return AppColorsLight.primaryGreen;
          }

          return AppColorsLight.unableText;
        },
      ),
      trackColor: WidgetStateProperty.resolveWith(
            (states) {
          if ( states.contains(WidgetState.selected) ) {
            return AppColorsLight.primaryGreen.withValues(alpha: 0.35);
          }

          return AppColorsLight.secondaryBackground;
        },
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
            (states) {
          if ( states.contains(WidgetState.selected) ) {
            return AppColorsLight.primaryGreen;
          }

          return Colors.transparent;
        },
      ),
      checkColor: WidgetStateProperty.all(
        AppColorsLight.primaryBackground,
      ),
      side: BorderSide(
        color: Colors.white.withValues(alpha: 0.12),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColorsLight.secondaryBackground,
      selectedColor: AppColorsLight.primaryGreen.withValues(alpha: 0.12),
      disabledColor: AppColorsLight.unableText.withValues(alpha: 0.08),
      secondarySelectedColor:
      AppColorsLight.primaryGreen.withValues(alpha: 0.12),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      labelStyle: const TextStyle(
        color: AppColorsLight.secondaryText,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: const TextStyle(
        color: AppColorsLight.primaryGreen,
        fontWeight: FontWeight.w600,
      ),
      brightness: Brightness.light,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: Colors.white.withValues(alpha: 0.04),
        ),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColorsLight.elevatedCardBackground,
      contentTextStyle: const TextStyle(
        color: AppColorsLight.primaryText,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      behavior: SnackBarBehavior.floating,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColorsLight.cardsBackground,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColorsLight.primaryGreen,
      linearTrackColor: AppColorsLight.secondaryBackground,
      circularTrackColor: AppColorsLight.secondaryBackground,
    ),
    iconTheme: const IconThemeData(
      color: AppColorsLight.primaryText,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: AppColorsLight.secondaryText,
      textColor: AppColorsLight.primaryText,
      tileColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColorsLight.cardsBackground,
      surfaceTintColor: Colors.transparent,
      modalBackgroundColor: AppColorsLight.cardsBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColorsLight.navBarTabBarBackground,
      selectedItemColor: AppColorsLight.primaryGreen,
      unselectedItemColor: AppColorsLight.tertiaryText,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColorsLight.navBarTabBarBackground,
      indicatorColor: AppColorsLight.primaryGreen.withValues(alpha: 0.14),
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      labelTextStyle: WidgetStateProperty.resolveWith(
            (states) {
          final selected = states.contains(WidgetState.selected);

          return TextStyle(
            color: ( selected )
                ? AppColorsLight.primaryGreen
                : AppColorsLight.tertiaryText,
            fontWeight: ( selected )
                ? FontWeight.w600
                : FontWeight.w500,
            fontSize: 12,
          );
        },
      ),
      iconTheme: WidgetStateProperty.resolveWith(
            (states) {
          final selected = states.contains(WidgetState.selected);

          return IconThemeData(
            color: ( selected )
                ? AppColorsLight.primaryGreen
                : AppColorsLight.tertiaryText,
          );
        },
      ),
    ),
  );

}