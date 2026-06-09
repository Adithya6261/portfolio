import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData buildDark() {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.darkBg,
      canvasColor: AppColors.darkBg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.brandMid,
        secondary: AppColors.brandEnd,
        surface: AppColors.darkSurface,
        onPrimary: Colors.white,
        onSurface: AppColors.darkText,
      ),
      textTheme: AppTextStyles.buildTextTheme(
        AppColors.darkText,
        AppColors.darkMuted,
      ),
      dividerColor: AppColors.darkBorder,
      cardColor: AppColors.darkSurface,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
    );
  }

  static ThemeData buildLight() {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.lightBg,
      canvasColor: AppColors.lightBg,
      colorScheme: const ColorScheme.light(
        primary: AppColors.brandMid,
        secondary: AppColors.brandStart,
        surface: AppColors.lightSurface,
        onPrimary: Colors.white,
        onSurface: AppColors.lightText,
      ),
      textTheme: AppTextStyles.buildTextTheme(
        AppColors.lightText,
        AppColors.lightMuted,
      ),
      dividerColor: AppColors.lightBorder,
      cardColor: AppColors.lightSurface,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
    );
  }
}

extension SurfaceColors on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  Color get surface =>
      isDark ? AppColors.darkSurface : AppColors.lightSurface;
  Color get surfaceAlt =>
      isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt;
  Color get borderColor =>
      isDark ? AppColors.darkBorder : AppColors.lightBorder;
  Color get textColor => isDark ? AppColors.darkText : AppColors.lightText;
  Color get mutedColor => isDark ? AppColors.darkMuted : AppColors.lightMuted;
}
