import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    const accent = Color(0xFFEAFF54);
    return ThemeData(
      useMaterial3: true,
      colorScheme:
          ColorScheme.fromSeed(seedColor: accent, brightness: Brightness.light),
      scaffoldBackgroundColor: const Color(0xFFF7F7F5),
      cardTheme: const CardThemeData(
          color: Colors.white, elevation: 0, margin: EdgeInsets.zero),
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none)),
      navigationBarTheme: const NavigationBarThemeData(height: 68),
    );
  }
}
