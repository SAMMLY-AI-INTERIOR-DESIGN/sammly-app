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
  });

  final TextEditingController controller;
  final String thing;
  final String? Function(String?)? validator;
  final bool ispassword;
  final IconData? preffixicon;
  final IconData? suffixicon;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        obscureText: widget.ispassword ? _obscureText : false,
        controller: widget.controller,
        validator: widget.validator,
        style: AppTextStyles.body14Regular.copyWith(color: AppColors.blackColor), // استخدام الخطوط
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          filled: true,
          fillColor: Colors.transparent,
          prefixIcon: widget.preffixicon != null
              ? Icon(widget.preffixicon, color: Colors.grey[600], size: 22.sp)
              : null,
          suffixIcon: widget.ispassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
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
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(width: 1.w, color: Colors.grey.withValues(alpha: 0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(width: 1.5.w, color: AppColors.primaryColor), // استخدام الأزرق
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(width: 1.w, color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(width: 1.5.w, color: Colors.red),
          ),
          hintText: widget.thing,
          hintStyle: AppTextStyles.hint12Light.copyWith(fontSize: 14.sp), // استخدام خط الـ Hint
        ),
      ),
    );
  }
}