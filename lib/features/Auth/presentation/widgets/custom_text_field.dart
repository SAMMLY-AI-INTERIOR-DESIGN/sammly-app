import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.thing,
    required this.validator,
    this.ispassword = false,
    this.preffixicon,
    this.suffixicon,
    this.isSuccess = false, // 💡 ضفنا حالة النجاح
    this.hasError = false, // 💡 ضفنا حالة الخطأ
    this.maxLines = 1,
    this.hasBorder = true,
  });

  final TextEditingController controller;
  final String thing;
  final String? Function(String?)? validator;
  final bool ispassword;
  final IconData? preffixicon;
  final IconData? suffixicon;
  final bool isSuccess;
  final bool hasError;
  final int maxLines;
  final bool hasBorder;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    // تحديد لون الخلفية بناءً على الحالة (فاطمة ديزاين)
    Color getFillColor() {
      if (widget.hasError) return Colors.red.withValues(alpha: 0.08);
      if (widget.isSuccess) {
        return AppColors.secondaryColor.withValues(alpha: 0.08);
      }
      return Colors.transparent;
    }

    // تحديد لون الإطار بناءً على الحالة
    Color getBorderColor() {
      if (widget.hasError) return Colors.red;
      if (widget.isSuccess) return AppColors.secondaryColor;
      return Colors.grey.withValues(alpha: 0.3);
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        obscureText: widget.ispassword ? _obscureText : false,
        controller: widget.controller,
        validator: widget.validator,
        maxLines: widget.maxLines,
        style: AppTextStyles.body14Regular.copyWith(
          color: AppColors.blackColor,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 18.h,
            horizontal: 16.w,
          ),
          filled: true,
          fillColor: getFillColor(), // تطبيق لون الخلفية
          // أيقونة البداية
          prefixIcon: widget.preffixicon != null
              ? Icon(
                  widget.preffixicon,
                  color: widget.hasError
                      ? Colors.red
                      : (widget.isSuccess
                            ? AppColors.secondaryColor
                            : Colors.grey[600]),
                  size: 22.sp,
                )
              : null,

          // أيقونة النهاية (العين أو علامة الصح/الخطأ)
          suffixIcon: widget.hasError
              ? Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                  size: 22.sp,
                ) // علامة الخطأ
              : widget.isSuccess
              ? Icon(
                  Icons.check_circle_outline,
                  color: AppColors.secondaryColor,
                  size: 22.sp,
                ) // علامة الصح
              : widget.ispassword
              ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey[600],
                    size: 22.sp,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : widget.suffixicon != null
              ? Icon(widget.suffixicon, color: Colors.grey[600], size: 22.sp)
              : null,

          // الإطارات
          border: widget.hasBorder ? null : InputBorder.none,
          enabledBorder: widget.hasBorder ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(width: 1.w, color: getBorderColor()),
          ) : InputBorder.none,
          focusedBorder: widget.hasBorder ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
              width: 1.5.w,
              color: AppColors.primaryColor,
            ), // الأزرق في الفوكس
          ) : InputBorder.none,
          errorBorder: widget.hasBorder ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(width: 1.w, color: Colors.red),
          ) : InputBorder.none,
          focusedErrorBorder: widget.hasBorder ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(width: 1.5.w, color: Colors.red),
          ) : InputBorder.none,

          hintText: widget.thing,
          hintStyle: AppTextStyles.hint12Light.copyWith(fontSize: 14.sp),
        ),
      ),
    );
  }
}
