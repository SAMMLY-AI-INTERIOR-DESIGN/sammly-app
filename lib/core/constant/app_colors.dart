import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF2858A4);
  static const Color secondaryColor = Color(0xFF2AC994);
  static const Color blackColor = Color(0xFF46565D);
  static const Color bg1Color = Color(0xFFEBF2FB);
  static const Color bg2Color = Color(0xFFE5F6F2);
  static const Color whiteColor = Color(0xFFF8FAFC);
  static const Color activeNavBarBg = Color(0xFFBCCBE3);


  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      primaryColor,
      primaryColor,
      Color.fromARGB(255, 27, 176, 127),
      Color.fromARGB(255, 27, 176, 127),
    ],
     stops: [
      0.0,
      0.45,
      0.55,
      1.0
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
   
  );
  static const LinearGradient navBgGradient = LinearGradient(
    colors: [
      bg2Color,
      bg1Color,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
}
