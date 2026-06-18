import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';

class EarnView extends StatelessWidget {
  const EarnView({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.blackColor2, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isArabic ? "اربح توكنز" : "Earn Tokens",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor2,
            fontFamily: 'Manrope',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Reward Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                gradient: const LinearGradient(
                  colors: [Color(0xFF2858A4), Color(0xFF23B5A0)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isArabic ? "توكنز مجانية" : "Free Tokens",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontFamily: 'Manrope',
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.star, color: const Color(0xFFFFD700), size: 36.sp),
                            SizedBox(width: 8.w),
                            Text(
                              "15",
                              style: TextStyle(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                fontFamily: 'Manrope',
                                height: 1.0,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Padding(
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: Text(
                                isArabic ? "توكن" : "Tokens",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: 'Manrope',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          isArabic
                              ? "احصل على 15 توكن مجاني كل شهر عند فتح حسابك!"
                              : "Get 15 free tokens every month when you open your account!",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white.withOpacity(0.9),
                            height: 1.4,
                            fontFamily: 'Manrope',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 100.w,
                    height: 100.h,
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: 5.h,
                          right: -5.w,
                          child: SvgPicture.asset(AppImages.tinystar3, width: 14.w),
                        ),
                        Positioned(
                          top: 15.h,
                          left: 10.w,
                          child: SvgPicture.asset(AppImages.tinystar2, width: 6.w),
                        ),
                        Positioned(
                          bottom: 35.h,
                          left: -5.w,
                          child: SvgPicture.asset(AppImages.tinystar3, width: 12.w),
                        ),
                        Positioned(
                          bottom: 15.h,
                          left: 15.w,
                          child: SvgPicture.asset(AppImages.tinystar, width: 6.w),
                        ),
                        Positioned(
                          bottom: 5.h,
                          right: 15.w,
                          child: SvgPicture.asset(AppImages.tinystar, width: 5.w),
                        ),
                        SvgPicture.asset(
                          AppImages.earnIcon,
                          width: 80.w,
                          height: 80.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24.h),
            
            Text(
              isArabic ? "طرق كسب التوكنز" : "Ways to earn tokens",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2E2E2E),
                fontFamily: 'Manrope',
              ),
            ),
            SizedBox(height: 16.h),
            
            // Item 1
            WayToEarnCard(
              title: isArabic ? "شارك تصميماتك" : "Share your designs",
              iconPath: AppImages.sharetoearn, 
              tokensAmount: "1",
              tokensLabel: isArabic ? "توكن" : "Token",
              description: isArabic 
                  ? "شارك تصميماتك للحصول على 1\nتوكن في كل مرة" 
                  : "Share your designs to get 1\ntoken each time",
              rightMainText: isArabic ? "مجاني" : "Free",
              rightSubText: isArabic ? "/منشور" : "/post",
              primaryColor: const Color(0xFF3C60B6),
              bgColor: const Color(0xFFF1F4FA),
            ),
            
            // Item 2
            WayToEarnCard(
              title: isArabic ? "تلقّي الإعجابات" : "Receive Likes",
              iconPath: AppImages.totallikes,
              tokensAmount: "15",
              tokensLabel: isArabic ? "توكن" : "Tokens",
              description: isArabic 
                  ? "إذا حصل منشورك على 20 إعجاباً،\nستحصل على 15 توكن." 
                  : "If your post gets 20 likes, you'll\nget 15 tokens.",
              rightMainText: isArabic ? "إعجاب 20" : "Likes 20",
              rightSubText: isArabic ? "/منشور" : "/post",
              primaryColor: const Color(0xFF23B5A0),
              bgColor: const Color(0xFFEAFAF7),
            ),
            
            // Item 3
            WayToEarnCard(
              title: isArabic ? "تلقّي الإعجابات" : "Receive Likes",
              iconPath: AppImages.totallikes,
              tokensAmount: "25",
              tokensLabel: isArabic ? "توكن" : "Tokens",
              description: isArabic 
                  ? "إذا حصل منشورك على 50 إعجاباً،\nستحصل على 25 توكن." 
                  : "If your post gets 50 likes, you'll\nget 25 tokens.",
              rightMainText: isArabic ? "إعجاب 50" : "Likes 50",
              rightSubText: isArabic ? "/منشور" : "/post",
              primaryColor: const Color(0xFF8B5CF6),
              bgColor: const Color(0xFFF5F0FF),
            ),

            // Item 4
            WayToEarnCard(
              title: isArabic ? "تلقّي الإعجابات" : "Receive Likes",
              iconPath: AppImages.totallikes,
              tokensAmount: "45",
              tokensLabel: isArabic ? "توكن" : "Tokens",
              description: isArabic 
                  ? "إذا حصل منشورك على 100 إعجاب،\nستحصل على 45 توكن." 
                  : "If your post gets 100 likes,\nyou'll get 45 tokens.",
              rightMainText: isArabic ? "إعجاب 100" : "Likes 100",
              rightSubText: isArabic ? "/منشور" : "/post",
              primaryColor: const Color(0xFFD97706),
              bgColor: const Color(0xFFFFFBEB),
            ),
          ],
        ),
      ),
    );
  }
}

class WayToEarnCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final String tokensAmount;
  final String tokensLabel;
  final String description;
  final String rightMainText;
  final String rightSubText;
  final Color primaryColor;
  final Color bgColor;

  const WayToEarnCard({
    super.key,
    required this.title,
    required this.iconPath,
    required this.tokensAmount,
    required this.tokensLabel,
    required this.description,
    required this.rightMainText,
    required this.rightSubText,
    required this.primaryColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 14.sp,
                  height: 14.sp,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                SizedBox(width: 6.w),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Container(
                width: 70.w,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: primaryColor.withValues(alpha: 0.15),
                    width: 1.w,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tokensAmount,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Manrope',
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      tokensLabel,
                      style: TextStyle(
                        color: const Color(0xFF5B5B5B),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Manrope',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  description,
                  style: TextStyle(
                    color: const Color(0xFF5B5B5B),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Manrope',
                    height: 1.4,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    rightMainText,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Manrope',
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    rightSubText,
                    style: TextStyle(
                      color: const Color(0xFF5B5B5B),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Manrope',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
