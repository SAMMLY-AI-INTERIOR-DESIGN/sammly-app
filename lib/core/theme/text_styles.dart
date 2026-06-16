import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static const String primaryFont = 'Manrope';

  // ==========================================
  // Headings & Titles (العناوين الكبيرة والأساسية)
  // ==========================================

  // متكرر في: Share & earn tokens, Create new password
  static TextStyle heading28ExtraBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 28.sp,
    fontWeight: FontWeight.w800,
    color: Color(0xFF2E2E2E),
  );

  // متكرر في: Visualize your room with AI
  static TextStyle heading24SemiBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: Color(0xFFF8FAFC),
  );

  // متكرر في: Terms & Conditions, Change Password (Headers)
  static TextStyle title20Bold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: Color(0xFF2E2E2E),
  );

  // متكرر في: Welcome, Message sent successfully, Bedroom
  static TextStyle title20SemiBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: Color(0xFF2E2E2E),
  );

  // متكرر في: Browse design categories
  static TextStyle title18SemiBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: Color(0xFF2E2E2E),
  );

  // ==========================================
  // Body Text & Subtitles (النصوص العادية والقوائم)
  // ==========================================

  // متكرر في: القوائم (Support, View My Profile...) وبعض النصوص الطويلة
  static TextStyle body16Medium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: Color(0xFF2E2E2E),
  );

  static TextStyle body16SemiBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Color(0xFF2E2E2E),
  );

  // متكرر في: النصوص العادية (Reach out to us, Thank you for contacting)
  static TextStyle body16Regular = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xFF46565D), // أحياناً بيكون 0xFF5B5B5B
  );

  // متكرر في: الوصف الصغير (Explore ready-made styles)
  static TextStyle body14Regular = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xFF5B5B5B),
  );

  // ==========================================
  // Buttons & Badges (الزراير والعلامات)
  // ==========================================

  // متكرر في: زرار Submit
  static TextStyle button24Medium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    color: Color(0xFFF8FAFC),
  );

  // متكرر في: زرار Start Generate
  static TextStyle button20Medium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    color: Color(0xFFF8FAFC),
  );

  // متكرر في: Upgrade PRO
  static TextStyle button16MediumBlue = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: Color(0xFF2858A4),
  );

  // متكرر في: AI POWERED badge
  static TextStyle badge14SemiBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: Color(0xFF46565D),
  );

  // ==========================================
  // Input Fields Hints (نصوص حقول الإدخال - كانت Poppins في التصميم)
  // ==========================================
  static TextStyle hint12Light = TextStyle(
    fontFamily: primaryFont, // يفضل توحيدها لـ Manrope بدل Poppins
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xFFA2A0A0),
  );

  static TextStyle title15extraBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 15.sp,
    fontWeight: FontWeight.w800,
    color: Color(0xFF46565D),
  );
}
