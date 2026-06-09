import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand gradient (Linear / Stripe inspired)
  static const Color brandStart = Color(0xFF7C5CFF);
  static const Color brandMid = Color(0xFF5B8DEF);
  static const Color brandEnd = Color(0xFF21D4FD);

  static const Color accentPink = Color(0xFFFF7AB8);
  static const Color accentEmerald = Color(0xFF10B981);
  static const Color accentAmber = Color(0xFFF59E0B);

  // Dark theme
  static const Color darkBg = Color(0xFF07070B);
  static const Color darkSurface = Color(0xFF0E0E14);
  static const Color darkSurfaceAlt = Color(0xFF14141C);
  static const Color darkBorder = Color(0x1AFFFFFF);
  static const Color darkText = Color(0xFFEDEDF1);
  static const Color darkMuted = Color(0xFF8B8B96);

  // Light theme
  static const Color lightBg = Color(0xFFFAFAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceAlt = Color(0xFFF3F3F7);
  static const Color lightBorder = Color(0x11000000);
  static const Color lightText = Color(0xFF0B0B12);
  static const Color lightMuted = Color(0xFF5C5C68);

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandStart, brandMid, brandEnd],
  );

  static LinearGradient textGradient() => const LinearGradient(
        colors: [brandStart, accentPink, brandEnd],
      );
}
