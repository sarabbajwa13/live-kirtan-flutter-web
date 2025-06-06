import 'package:flutter/material.dart';

class AppColors {
  static const backgroundColor = Colors.white;
  static const textColorPrimary = Colors.black87;
  static const textColorSecondary = Colors.black54;
}

class AppStyles {
  static const defaultShadows = [
    BoxShadow(
      color: Colors.white,
      offset: Offset(-4, -4),
      blurRadius: 6,
    ),
    BoxShadow(
      color: Color(0x1A000000), // Colors.black.withOpacity(0.1)
      offset: Offset(4, 4),
      blurRadius: 6,
    ),
  ];

  static const cardShadows = [
    BoxShadow(
      color: Colors.white,
      offset: Offset(-6, -6),
      blurRadius: 8,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(6, 6),
      blurRadius: 8,
    ),
  ];

  static const neumorphicStrongShadows = [
    BoxShadow(
      color: Colors.white,
      offset: Offset(-10, -10),
      blurRadius: 24,
    ),
    BoxShadow(
      color: Color(0x33000000), // Colors.black.withOpacity(0.2)
      offset: Offset(10, 10),
      blurRadius: 24,
    ),
  ];
}

class AppConfig {
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
  static const double cardBorderRadius = 16.0;
  static const int paymentAmount = 10000;
} 