import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand
  static const Color accent = Color(0xFF6C63FF);
  static const Color accentLight = Color(0xFF8B85FF);

  // Light theme
  static const Color lightBackground = Color(0xFFF8F9FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceBorder = Color(0xFFE5E7EF);
  static const Color lightInputFill = Color(0xFFF2F3F8);

  static const Color lightTextPrimary = Color(0xFF171B2C);
  static const Color lightTextSecondary = Color(0xFF666B80);
  static const Color lightTextHint = Color(0xFF969AAC);

  // Dark theme
  static const Color darkBackground = Color(0xFF0A0E1A);
  static const Color darkSurface = Color(0xFF131929);
  static const Color darkSurfaceBorder = Color(0xFF292E42);
  static const Color darkInputFill = Color(0xFF0D1120);

  static const Color darkTextPrimary = Color(0xFFF1F1F7);
  static const Color darkTextSecondary = Color(0xFFA2A6BB);
  static const Color darkTextHint = Color(0xFF747991);

  // Status
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Misc
  static const Color dotInactive = Color(0xFFBFC2D2);

  // Legacy aliases - light defaults.
  // Prefer Theme.of(context) for theme-aware widgets.
  static const Color background = lightBackground;
  static const Color surface = lightSurface;
  static const Color surfaceBorder = lightSurfaceBorder;
  static const Color inputFill = lightInputFill;
  static const Color textPrimary = lightTextPrimary;
  static const Color textSecondary = lightTextSecondary;
  static const Color textHint = lightTextHint;
}
