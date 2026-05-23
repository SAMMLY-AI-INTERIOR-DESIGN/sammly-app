import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF2858A4);
  static const Color secondaryColor = Color(0xFF23B5A0);
  static const Color blackColor = Color(0xFF46565D);
  static const Color bg1Color = Color(0xFFEBF2FB);
  static const Color bg2Color = Color(0xFFE5F6F2);
  static const Color whiteColor = Color(0xFFF8FAFC);
  static const Color activeNavBarBg = Color(0xFFBCCBE3);
  static const Color starColor = Color(0xFFFDD835);
  static const Color tokensColor = Color(0xFF1E4179);
  static const Color searchTextFieldColor = Color(0xFFEAEEF6);
  static const Color greyColor = Color(0xFF516067);
  static const Color blackColor2 = Color(0xFF2E2E2E);
  static const Color textFieldBodyColor = Color(0xFFE4F0F2);
  static const Color redColor = Color(0xFFFF3C3C);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, primaryColor, secondaryColor, secondaryColor],
    stops: [0.0, 0.45, 0.55, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient primaryGradient2 = LinearGradient(
    colors: [secondaryColor, primaryColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient primaryGradient3 = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient navBgGradient = LinearGradient(
    colors: [bg2Color, bg1Color],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient scafoldBgGradient = LinearGradient(
    colors: [bg1Color, bg2Color],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient iconGradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  
}
