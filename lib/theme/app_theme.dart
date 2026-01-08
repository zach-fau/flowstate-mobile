import 'package:flutter/material.dart';

/// App color palette
class AppColors {
  // Dark theme colors (default)
  static const darkBackground = Color(0xFF0D0D0D);
  static const darkSurface = Color(0xFF1A1A1A);
  static const darkSurfaceLight = Color(0xFF262626);

  // Light theme colors
  static const lightBackground = Color(0xFFF5F5F5);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceLight = Color(0xFFE8E8E8);

  // Accent colors
  static const primary = Color(0xFF6366F1); // Indigo
  static const primaryLight = Color(0xFF818CF8);
  static const primaryDark = Color(0xFF4F46E5);

  // Text colors
  static const textPrimaryDark = Color(0xFFF5F5F5);
  static const textSecondaryDark = Color(0xFFA3A3A3);
  static const textMutedDark = Color(0xFF525252);

  static const textPrimaryLight = Color(0xFF171717);
  static const textSecondaryLight = Color(0xFF525252);
  static const textMutedLight = Color(0xFFA3A3A3);

  // Status colors
  static const success = Color(0xFF22C55E);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);
}

/// App typography
class AppTypography {
  static const fontFamily = 'Inter';

  static const display = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w600,
    letterSpacing: -1,
  );

  static const heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
  );

  static const heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static const body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
}

/// App theme configuration
class AppTheme {
  /// Dark theme (default)
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.primaryLight,
        surface: AppColors.darkSurface,
        error: AppColors.error,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.textPrimaryDark,
        elevation: 0,
      ),
      cardTheme: const CardTheme(
        color: AppColors.darkSurface,
        elevation: 0,
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.display.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        headlineLarge: AppTypography.heading1.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        headlineMedium: AppTypography.heading2.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        headlineSmall: AppTypography.heading3.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        bodyLarge: AppTypography.body.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        bodyMedium: AppTypography.bodySmall.copyWith(
          color: AppColors.textSecondaryDark,
        ),
        bodySmall: AppTypography.caption.copyWith(
          color: AppColors.textMutedDark,
        ),
        labelLarge: AppTypography.button.copyWith(
          color: AppColors.textPrimaryDark,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimaryDark,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: const BorderSide(color: AppColors.darkSurfaceLight),
        ),
      ),
      sliderTheme: const SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: AppColors.darkSurfaceLight,
        thumbColor: AppColors.primary,
      ),
    );
  }

  /// Light theme
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.primaryLight,
        surface: AppColors.lightSurface,
        error: AppColors.error,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        foregroundColor: AppColors.textPrimaryLight,
        elevation: 0,
      ),
      cardTheme: const CardTheme(
        color: AppColors.lightSurface,
        elevation: 0,
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.display.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        headlineLarge: AppTypography.heading1.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        headlineMedium: AppTypography.heading2.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        headlineSmall: AppTypography.heading3.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        bodyLarge: AppTypography.body.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        bodyMedium: AppTypography.bodySmall.copyWith(
          color: AppColors.textSecondaryLight,
        ),
        bodySmall: AppTypography.caption.copyWith(
          color: AppColors.textMutedLight,
        ),
        labelLarge: AppTypography.button.copyWith(
          color: AppColors.textPrimaryLight,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimaryLight,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: const BorderSide(color: AppColors.lightSurfaceLight),
        ),
      ),
      sliderTheme: const SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: AppColors.lightSurfaceLight,
        thumbColor: AppColors.primary,
      ),
    );
  }
}
