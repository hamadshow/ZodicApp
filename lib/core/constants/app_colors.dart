import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF2F6FED);
  static const Color primaryContainer = Color(0xFFE6F0FF);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFF3B82F6);
  static const Color secondaryContainer = Color(0xFFDCEBFF);
  static const Color onSecondary = Color(0xFF0F172A);

  static const Color background = Color(0xFFF5F7FB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceContainer = Color(0xFFF1F5F9);
  static const Color surfaceVariant = Color(0xFFE7EEF9);

  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF4B5563);
  static const Color textMuted = Color(0xFF6B7280);
  static const Color textDisabled = Color(0xFF9CA3AF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFF1F5F9);
  static const Color divider = Color(0xFFE2E8F0);

  static const Color success = Color(0xFF1F9D6A);
  static const Color successContainer = Color(0xFFDCFCE7);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningContainer = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFDC2626);
  static const Color errorContainer = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF2563EB);
  static const Color infoContainer = Color(0xFFDBEAFE);

  static const Color positiveAmount = success;
  static const Color negativeAmount = error;
  static const Color profit = success;
  static const Color loss = error;
  static const Color income = info;
  static const Color expense = warning;
  static const Color payable = warning;
  static const Color receivable = success;
  static const Color pending = warning;
  static const Color paid = success;
  static const Color overdue = error;

  static const Color accent = primary;
  static const Color accentSoft = primaryContainer;
  static const Color primarySoft = primaryContainer;
  static const Color surfaceElevated = surface;
  static const Color successSoft = successContainer;
  static const Color errorSoft = errorContainer;
  static const Color shadow = Color(0x1F0F172A);
  static const Color backgroundGradientStart = background;
  static const Color backgroundGradientEnd = surfaceVariant;
}
