import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custom_heart_item.dart';
import 'package:sammly/core/widgets/avatar_widget.dart';
import 'package:sammly/features/notifications/data/model/notifications_model.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sammly/generated/l10n.dart';
import 'package:intl/intl.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationItemModel item;

  const NotificationItemWidget({super.key, required this.item});

  String _formatDate(String dateStr, bool isEgypt) {
    if (dateStr.isEmpty) return '';
    try {
      DateTime? parsedDate;
      String cleaned = dateStr.trim();
      
      // 1. Try parsing as milliseconds timestamp if it's purely digits
      if (RegExp(r'^\d+$').hasMatch(cleaned)) {
        int timestamp = int.parse(cleaned);
        // If it's 10 digits, it's likely seconds, not milliseconds
        if (cleaned.length == 10) {
          timestamp *= 1000;
        }
        parsedDate = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
      } else {
        // 2. Try standard parse first
        parsedDate = DateTime.tryParse(cleaned);
        
        // 3. Try HttpDate parsing
        if (parsedDate == null) {
          try {
            parsedDate = HttpDate.parse(cleaned);
          } catch (_) {}
        }
        
        // 4. Try cleaning timezone name suffixes (UTC/GMT) if still null
        if (parsedDate == null) {
          String customCleaned = cleaned.replaceAll(RegExp(r'\s+(UTC|GMT)$', caseSensitive: false), 'Z');
          if (customCleaned.contains(' ') && !customCleaned.contains('T')) {
            customCleaned = customCleaned.replaceAll(' ', 'T');
          }
          parsedDate = DateTime.tryParse(customCleaned);
        }
        
        // 5. If parsed but isUtc is false and no timezone info was in the original string, treat it as UTC
        if (parsedDate != null) {
          if (!parsedDate.isUtc && !cleaned.toUpperCase().contains('Z') && !cleaned.contains('+')) {
            String formatted = cleaned.replaceAll(' ', 'T');
            if (!formatted.endsWith('Z')) {
              formatted += 'Z';
            }
            parsedDate = DateTime.tryParse(formatted) ?? parsedDate;
          }
        }
      }

      if (parsedDate == null) return dateStr;

      final localDate = isEgypt
          ? parsedDate.toUtc().add(const Duration(hours: 3))
          : parsedDate.toLocal();
      final now = isEgypt
          ? DateTime.now().toUtc().add(const Duration(hours: 3))
          : DateTime.now();
      final difference = now.difference(localDate);

      if (difference.inDays == 0 && now.day == localDate.day) {
        return DateFormat.jm().format(localDate); // e.g. 5:08 PM
      } else if (difference.inDays < 7) {
        return DateFormat('EEE, h:mm a').format(localDate); // e.g. Wed, 5:08 PM
      } else {
        return DateFormat('MMM d, yyyy').format(localDate); // e.g. Oct 24, 2023
      }
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.read<ProfileCubit>().currentProfile;
    final country = profile?.country?.toLowerCase() ?? '';
    final isEgypt = country.contains('egypt');

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 26.r,
                backgroundColor: AppColors.bg1Color,
                child: AvatarWidget(
                  avatarPath: item.avatar,
                  gender: null,
                  width: 52.r,
                  height: 52.r,
                  borderRadius: BorderRadius.circular(26.r),
                ),
              ),
              PositionedDirectional(
                bottom: 0,
                end: -8.w,
                child: CustomHeartItem(),
              ),
            ],
          ),

          SizedBox(width: 16.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: AppTextStyles.body16Medium),
                SizedBox(height: 4.h),
                Text(
                  S.of(context).likeYourSharedDesign,
                  style: AppTextStyles.body14Regular.copyWith(
                    color: AppColors.greyColor.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),

          Text(
            _formatDate(item.createdAt, isEgypt),
            style: AppTextStyles.body14Regular.copyWith(
              color: AppColors.greyColor.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
