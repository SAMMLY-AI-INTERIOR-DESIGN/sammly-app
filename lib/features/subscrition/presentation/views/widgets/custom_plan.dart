import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sammly/generated/l10n.dart';

class CustomPlan extends StatelessWidget {
  final String iconPath;
  final String title;
  final String tokensAmount;
  final String description;
  final String price;
  final String? priceSub;
  final Color primaryColor;
  final Color bgColor;
  final Color? borderColor;
  final bool isFree;
  final bool isSelected;
  final bool isLoading;
  final VoidCallback? onTap;

  const CustomPlan({
    super.key,
    required this.iconPath,
    required this.title,
    required this.tokensAmount,
    required this.description,
    required this.price,
    this.priceSub,
    required this.primaryColor,
    required this.bgColor,
    this.borderColor,
    this.isFree = false,
    this.isSelected = false,
    this.isLoading = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardBorderColor = borderColor ?? primaryColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsetsDirectional.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w), // Reduced padding
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14.r), // حواف ناعمة ومتناسقة
          border: Border.all(
            width: isSelected ? 2.w : 1.w,
            color: isSelected
                ? cardBorderColor
                : cardBorderColor.withValues(alpha: 0.3),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. الـ Badge العلوي الصغير
            Container(
              height: 26.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    iconPath,
                    width: 14.w,
                    height: 14.h,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    title,
                    style: TextStyle(
                      color: const Color(0xFFF8FAFC),
                      fontSize: 13.sp,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600, // خليناه Semi-bold عشان يوضح
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // 2. صف محتويات الباقة الأساسي
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // بوكس الـ Tokens (الجانب الأيسر)
                Container(
                  width: 72.w, // مقاس مثالي ومحكوم بـ ScreenUtil
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    // خلفية خفيفة جداً متناسقة مع لون الباقة الأساسي زي الديزاين
                    color: primaryColor.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      width: 1.w,
                      color: primaryColor.withValues(alpha: 0.15),
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
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        S.of(context).tokens,
                        style: TextStyle(
                          color: const Color(0xFF5B5B5B),
                          fontSize: 12.sp,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 12.w),

                // النصوص التوضيحية (المنتصف)
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        description,
                        style: TextStyle(
                          color: const Color(0xFF2E2E2E),
                          fontSize: 13.sp,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 8.w),

                // بوكس السعر أو كلمة Free (الجانب الأيمن)
                if (isFree)
                  isLoading
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: SizedBox(
                            width: 24.w,
                            height: 24.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: primaryColor,
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            price,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 22.sp,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                else
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 8.w,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        width: 1.w,
                        color: primaryColor.withValues(alpha: 0.12),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          price,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 18.sp,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (priceSub != null) ...[
                          SizedBox(height: 2.h),
                          Text(
                            priceSub!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF5B5B5B),
                              fontSize: 11.sp,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
