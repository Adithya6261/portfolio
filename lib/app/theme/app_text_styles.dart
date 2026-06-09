import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextTheme buildTextTheme(Color textColor, Color mutedColor) {
    final inter = GoogleFonts.interTextTheme();
    return inter
        .copyWith(
          displayLarge: inter.displayLarge?.copyWith(
            fontSize: 72,
            height: 1.05,
            letterSpacing: -2.2,
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
          displayMedium: inter.displayMedium?.copyWith(
            fontSize: 52,
            letterSpacing: -1.6,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
          displaySmall: inter.displaySmall?.copyWith(
            fontSize: 36,
            letterSpacing: -1.0,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
          headlineMedium: inter.headlineMedium?.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: textColor,
            letterSpacing: -0.6,
          ),
          titleLarge: inter.titleLarge?.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: textColor,
            letterSpacing: -0.2,
          ),
          titleMedium: inter.titleMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
          bodyLarge: inter.bodyLarge?.copyWith(
            fontSize: 17,
            height: 1.6,
            color: mutedColor,
          ),
          bodyMedium: inter.bodyMedium?.copyWith(
            fontSize: 15,
            height: 1.6,
            color: mutedColor,
          ),
          labelLarge: inter.labelLarge?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor,
            letterSpacing: 0.2,
          ),
          labelSmall: inter.labelSmall?.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: mutedColor,
            letterSpacing: 1.4,
          ),
        );
  }

  static TextStyle mono(Color color, {double size = 13}) {
    return GoogleFonts.jetBrainsMono(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
    );
  }
}
