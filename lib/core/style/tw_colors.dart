import 'package:flutter/material.dart';

class TWColors {
  // Get colors based on brightness
  static TWColorScheme of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? _darkColors : _lightColors;
  }
}

class TWColorScheme {
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color border;
  final Color shadow;

  const TWColorScheme({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.border,
    required this.shadow,
  });
}

// Light theme colors
const _lightColors = TWColorScheme(
  primary: Color(0xFF4FC3C3),
  secondary: Color(0xFF2C5F7F),
  accent: Color(0xFF5B9FD8),
  background: Color(0xFFF5F5F5),
  surface: Color(0xFFFFFFFF),
  textPrimary: Color(0xFF1A1A1A),
  textSecondary: Color(0xFF6B7280),
  textMuted: Color(0xFF9CA3AF),
  border: Color(0xFFE5E7EB),
  shadow: Color(0xFF000000),
);

// Dark theme colors
const _darkColors = TWColorScheme(
  primary: Color(0xFF4FC3C3),
  secondary: Color(0xFF2C5F7F),
  accent: Color(0xFF5B9FD8),
  background: Color(0xFF2C3E50),
  surface: Color(0xFF34495E),
  textPrimary: Color(0xFFFFFFFF),
  textSecondary: Color(0xFFD1D5DB),
  textMuted: Color(0xFF9CA3AF),
  border: Color(0xFF4A5F7F),
  shadow: Color(0xFF000000),
);

// Legacy colors for backward compatibility
class TWColorsLegacy {
  // Primary
  static const Color blue100 = Color(0xFFDBEAFE);
  static const Color blue500 = Color(0xFF3B82F6);
  static const Color blue600 = Color(0xFF2563EB);
  static const Color blue700 = Color(0xFF1D4ED8);
  static const Color blue800 = Color(0xFF1E40AF);
  
  // Secondary
  static const Color emerald100 = Color(0xFFD1FAE5);
  static const Color emerald500 = Color(0xFF10B981);
  static const Color emerald600 = Color(0xFF059669);
  static const Color emerald800 = Color(0xFF065F46);
  
  // Neutral
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);
  
  // Accent
  static const Color amber500 = Color(0xFFF59E0B);
  static const Color rose500 = Color(0xFFF43F5E);
  static const Color violet500 = Color(0xFF8B5CF6);
}
