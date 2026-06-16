import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/generated/l10n.dart';

class RoomFilterWidget extends StatelessWidget {
  final List<String> allRooms;
  final List<String> selectedRooms;
  final Function(String) onRoomToggled;
  final VoidCallback onAllToggled;

  const RoomFilterWidget({
    super.key,
    required this.allRooms,
    required this.selectedRooms,
    required this.onRoomToggled,
    required this.onAllToggled,
  });

  @override
  Widget build(BuildContext context) {
    bool isAllSelected = selectedRooms.length == allRooms.length;

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 6.w,
      runSpacing: 7.h,
      children: [
        _buildChip(
          text: S.of(context).all,
          isActive: isAllSelected,
          onTap: onAllToggled,
        ),
        ...allRooms.map((room) {
          bool isActive = selectedRooms.contains(room);
          return _buildChip(
            text: room,
            isActive: isActive,
            onTap: () => onRoomToggled(room),
          );
        }),
      ],
    );
  }

  Widget _buildChip({
    required String text,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isActive ? null : AppColors.bg2Color,
          gradient: isActive ? AppColors.primaryGradient3 : null,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          text,
          style: AppTextStyles.body16Regular.copyWith(
            color: isActive ? Colors.white : AppColors.blackColor,
          ),
        ),
      ),
    );
  }
}
