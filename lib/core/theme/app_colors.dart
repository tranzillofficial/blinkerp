import 'package:flutter/material.dart';

/// All brand colours in one place.
/// Screens reference these constants — never raw hex strings.
class AppColors {
  AppColors._();

  // ── Base palette ──────────────────────────────────────────
  static const Color background = Color(0xFF0A0E1A);
  static const Color surface = Color(0xFF131929);
  static const Color surfaceBorder = Color(0xFF1E2235);
  static const Color inputFill = Color(0xFF0D1120);

  // ── Brand / accent ────────────────────────────────────────
  static const Color accent = Color(0xFF6C63FF);
  static const Color accentLight = Color(0xFF8B85FF);

  // ── Text ──────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFF1F1F1);
  static const Color textSecondary = Color(0xFF8E8EA8);
  static const Color textHint = Color(0xFF3A3D5C);

  // ── Status ────────────────────────────────────────────────
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // ── Misc ──────────────────────────────────────────────────
  static const Color dotInactive = Color(0xFF2A2D3E);
}
