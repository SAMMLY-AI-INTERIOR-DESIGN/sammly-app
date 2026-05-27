import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items; // 1. ضفنا ليستة القيم
  final ValueChanged<String?> onChanged; // 2. ضفنا دالة التغيير

  const CustomDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient3,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.textFieldBodyColor, 
          borderRadius: BorderRadius.circular(7.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTextStyles.body14Regular.copyWith(
                color: Colors.grey.shade600,
                fontSize: 12.sp,
              ),
            ),
            
            DropdownButtonFormField<String>(
              initialValue: value,
              icon: Icon(Icons.arrow_drop_down, color: Colors.teal.shade400),
              isExpanded: true, 
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              // 3. عرض القيم من الليستة المبعوتة
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: AppTextStyles.body14Regular,
                  ),
                );
              }).toList(),
              onChanged: onChanged, // 4. ربط دالة التغيير
            ),
          ],
        ),
      ),
    );
  }
}