import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static const String fontFamily = 'Manrope';

  static TextTheme get textTheme => lightTextTheme;

  static TextTheme get lightTextTheme =>
      _buildTextTheme(AppColors.lightTextPrimary, AppColors.lightTextSecondary);

  static TextTheme get darkTextTheme =>
      _buildTextTheme(AppColors.darkTextPrimary, AppColors.darkTextSecondary);

  static TextTheme _buildTextTheme(Color primary, Color secondary) {
    TextStyle style(double size, FontWeight weight, Color color) {
      return TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: const ['NotoSansArabic'],
        fontSize: size,
        fontWeight: weight,
        color: color,
      );
    }

    return TextTheme(
      displayLarge: style(32, FontWeight.w700, primary),
      headlineMedium: style(26, FontWeight.w700, primary),
      titleLarge: style(20, FontWeight.w600, primary),
      bodyLarge: style(16, FontWeight.w400, primary),
      bodyMedium: style(14, FontWeight.w400, secondary),
      bodySmall: style(13, FontWeight.w400, secondary),
      labelLarge: style(16, FontWeight.w600, primary),
    );
  }
}
