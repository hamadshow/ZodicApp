import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppColorScheme {
  AppColorScheme._();

  static ColorScheme light() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.textPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.textPrimary,
      tertiary: AppColors.info,
      onTertiary: AppColors.onPrimary,
      tertiaryContainer: AppColors.infoContainer,
      onTertiaryContainer: AppColors.textPrimary,
      error: AppColors.error,
      onError: AppColors.onPrimary,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.textPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.surfaceContainer,
      onSurfaceVariant: AppColors.textSecondary,
      outline: AppColors.border,
      outlineVariant: AppColors.borderLight,
      shadow: Color(0x1F0F172A),
      scrim: Color(0x66000000),
      inverseSurface: Color(0xFF0F172A),
      onInverseSurface: AppColors.onPrimary,
      inversePrimary: AppColors.primaryContainer,
      surfaceTint: AppColors.primary,
    );
  }

  static ColorScheme dark() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF70A5FF),
      onPrimary: Color(0xFF06121F),
      primaryContainer: Color(0xFF1E3A5F),
      onPrimaryContainer: Color(0xFFEAF2FF),
      secondary: Color(0xFF9CC3FF),
      onSecondary: Color(0xFF06121F),
      secondaryContainer: Color(0xFF243B5A),
      onSecondaryContainer: Color(0xFFEAF2FF),
      tertiary: Color(0xFF8AD0FF),
      onTertiary: Color(0xFF06121F),
      tertiaryContainer: Color(0xFF113A52),
      onTertiaryContainer: Color(0xFFEAF2FF),
      error: Color(0xFFFF6B6B),
      onError: Color(0xFF1A0F0F),
      errorContainer: Color(0xFF4C1D1D),
      onErrorContainer: Color(0xFFFEE2E2),
      surface: Color(0xFF0F172A),
      onSurface: Color(0xFFF8FAFC),
      surfaceContainerHighest: Color(0xFF1E293B),
      onSurfaceVariant: Color(0xFFCBD5E1),
      outline: Color(0xFF334155),
      outlineVariant: Color(0xFF1E293B),
      shadow: Color(0xFF000000),
      scrim: Color(0xCC000000),
      inverseSurface: Color(0xFFF8FAFC),
      onInverseSurface: Color(0xFF0F172A),
      inversePrimary: Color(0xFF214A8C),
      surfaceTint: Color(0xFF70A5FF),
    );
  }
}
