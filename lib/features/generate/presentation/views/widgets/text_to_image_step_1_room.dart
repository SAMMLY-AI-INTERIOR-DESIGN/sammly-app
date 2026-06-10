import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/functions.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custombutton.dart';

class TextToImageStep1Room extends StatelessWidget {
  final String? selectedRoom;
  final Function(String) onRoomSelected;
  final VoidCallback onNext;

  const TextToImageStep1Room({
    super.key,
    required this.selectedRoom,
    required this.onRoomSelected,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> rooms = [
      {'name': AppStrings.bathroom, 'image': AppImages.roomBathroom},
      {'name': AppStrings.bedroom, 'image': AppImages.roomBedroom},
      {'name': AppStrings.diningRoom, 'image': AppImages.roomDining},
      {'name': AppStrings.kitchen, 'image': AppImages.roomKitchen},
      {
        'name': AppStrings.livingRoom,
        'image': AppImages.roomLivingBohoTraditional,
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: ListView.separated(
                padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
                itemCount: rooms.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  final isSelected = selectedRoom == room['name'];
              
                  return GestureDetector(
                    onTap: () => onRoomSelected(room['name']!),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        gradient: isSelected ? AppColors.primaryGradient3 : null,
                        color: isSelected ? null : Colors.transparent,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Container(
                        height: 230.h,
                        decoration: BoxDecoration(
                          color: AppColors.roomItemBgColor,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(14.r),
                                ),
                                child: Image.asset(
                                  room['image']!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey.shade200,
                                      child: const Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.bg1Color.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(14.r),
                                ),
                              ),
                              child: Text(
                                room['name']!,
                                style: AppTextStyles.title18SemiBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          CustomButton(
            text: AppStrings.next,
            suffixIcon: AppImages.arrowRight,
            onPressed: selectedRoom != null
                ? onNext
                : () {
                    showCustomSnackBar(
                      context: context,
                      message: AppStrings.pleaseSelectARoom,
                      isError: true,
                    );
                  },
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
