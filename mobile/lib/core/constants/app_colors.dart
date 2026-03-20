import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Background
  static const Color background = Color(0xFF0A0A0F);
  static const Color surface = Color(0xFF161625);
  static const Color surfaceVariant = Color(0xFF1E1E30);
  static const Color card = Color(0xFF1A1A2E);

  // Primary gradient colors
  static const Color primaryPink = Color(0xFFFF2D78);
  static const Color primaryOrange = Color(0xFFFF6B35);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8A8A9A);
  static const Color textHint = Color(0xFF55556A);

  // Accent
  static const Color onlineGreen = Color(0xFF22C55E);
  static const Color gold = Color(0xFFFFD700);
  static const Color platinum = Color(0xFFE5E5E5);
  static const Color verified = Color(0xFF3B82F6);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryPink, primaryOrange],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient primaryGradientVertical = LinearGradient(
    colors: [primaryPink, primaryOrange],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFF1A0A1E), Color(0xFF0A0A0F)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardOverlayGradient = LinearGradient(
    colors: [Colors.transparent, Color(0xCC000000)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Divider / Border
  static const Color border = Color(0xFF2A2A3E);
  static const Color divider = Color(0xFF1F1F35);

  // Input
  static const Color inputFill = Color(0xFF1A1A2E);

  // Shimmer
  static const Color shimmerBase = Color(0xFF1A1A2E);
  static const Color shimmerHighlight = Color(0xFF2A2A3E);
}
