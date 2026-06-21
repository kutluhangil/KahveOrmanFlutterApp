import 'package:flutter/material.dart';

/// KahveOrman marka renkleri.
class KahveOrmanColors {
  KahveOrmanColors._();

  static const Color cream = Color(0xFFFAF4EC); // scaffold arka plan
  static const Color surface = Color(0xFFFFFFFF); // kart
  static const Color espresso = Color(0xFF2C211B); // metin
  static const Color muted = Color(0xFF81756F); // soluk metin
  static const Color caramel = Color(0xFFBB6A3C); // primary / CTA
}

/// Uygulamanın genel teması.
ThemeData kahveOrmanTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: KahveOrmanColors.cream,
    colorScheme: ColorScheme.fromSeed(
      seedColor: KahveOrmanColors.caramel,
      primary: KahveOrmanColors.caramel,
      surface: KahveOrmanColors.surface,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: KahveOrmanColors.cream,
      foregroundColor: KahveOrmanColors.espresso,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: KahveOrmanColors.espresso,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: KahveOrmanColors.caramel,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
  );
}
