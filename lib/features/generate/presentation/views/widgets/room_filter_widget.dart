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

    List<Widget> chips = [
      _buildChip(
        context,
        text: S.of(context).all,
        isActive: isAllSelected,
        onTap: onAllToggled,
      ),
      ...allRooms.map((room) {
        bool isActive = selectedRooms.contains(room);
        return _buildChip(
          context,
          text: room,
          isActive: isActive,
          onTap: () => onRoomToggled(room),
        );
      }),
    ];

    List<Widget> rows = [];
    for (int i = 0; i < chips.length; i += 3) {
      rows.add(
        Padding(
          padding: EdgeInsets.only(bottom: i + 3 < chips.length ? 7.h : 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: chips
                .skip(i)
                .take(3)
                .map(
                  (chip) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: chip,
                  ),
                )
                .toList(),
          ),
        ),
      );
    }

    return Column(children: rows);
  }

  Widget _buildChip(
    BuildContext context, {
    required String text,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isEnglish ? 14.w : 20.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: isActive ? null : AppColors.bg2Color,
          gradient: isActive ? AppColors.primaryGradient3 : null,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          text,
          style: AppTextStyles.body16Regular.copyWith(
            color: isActive ? Colors.white : AppColors.blackColor,
            fontSize: isEnglish ? 15.5.sp : 16.sp,
          ),
        ),
      ),
    );
  }
}
