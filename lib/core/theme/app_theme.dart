import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// Single source of truth for all ThemeData objects.
class AppTheme {
  AppTheme._();

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        fontFamily: AppTypography.fontFamily,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.accent,
          surface: AppColors.surface,
        ),
        textTheme: AppTypography.textTheme,
      );
}
