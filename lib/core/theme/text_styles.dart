import 'package:flutter/material.dart';

class AppTextStyles {
  static const String primaryFont = 'Manrope';

  // ==========================================
  // Headings & Titles (العناوين الكبيرة والأساسية)
  // ==========================================
  
  // متكرر في: Share & earn tokens, Create new password
  static const TextStyle heading28ExtraBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: Color(0xFF2E2E2E),
  );

  // متكرر في: Visualize your room with AI
  static const TextStyle heading24SemiBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Color(0xFFF8FAFC),
  );

  // متكرر في: Terms & Conditions, Change Password (Headers)
  static const TextStyle title20Bold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Color(0xFF2E2E2E),
  );

  // متكرر في: Welcome, Message sent successfully, Bedroom
  static const TextStyle title20SemiBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Color(0xFF2E2E2E),
  );

  // متكرر في: Browse design categories
  static const TextStyle title18SemiBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Color(0xFF2E2E2E),
  );

  // ==========================================
  // Body Text & Subtitles (النصوص العادية والقوائم)
  // ==========================================

  // متكرر في: القوائم (Support, View My Profile...) وبعض النصوص الطويلة
  static const TextStyle body16Medium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xFF2E2E2E),
  );

  // متكرر في: النصوص العادية (Reach out to us, Thank you for contacting)
  static const TextStyle body16Regular = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color(0xFF46565D), // أحياناً بيكون 0xFF5B5B5B
  );

  // متكرر في: الوصف الصغير (Explore ready-made styles)
  static const TextStyle body14Regular = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFF5B5B5B),
  );

  // ==========================================
  // Buttons & Badges (الزراير والعلامات)
  // ==========================================

  // متكرر في: زرار Submit
  static const TextStyle button24Medium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: Color(0xFFF8FAFC),
  );

  // متكرر في: زرار Start Generate
  static const TextStyle button20Medium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Color(0xFFF8FAFC),
  );

  // متكرر في: Upgrade PRO
  static const TextStyle button16MediumBlue = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xFF2858A4),
  );

  // متكرر في: AI POWERED badge
  static const TextStyle badge14SemiBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color(0xFF46565D),
  );

  // ==========================================
  // Input Fields Hints (نصوص حقول الإدخال - كانت Poppins في التصميم)
  // ==========================================
  static const TextStyle hint12Light = TextStyle(
    fontFamily: primaryFont, // يفضل توحيدها لـ Manrope بدل Poppins
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: Color(0xFFA2A0A0),
  );
}