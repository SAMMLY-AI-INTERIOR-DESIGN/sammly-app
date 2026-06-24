import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/avatar_widget.dart';
import 'package:sammly/core/widgets/custom_heart_item.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_state.dart';
import 'package:sammly/generated/l10n.dart';

class ProfileImageNameWidget extends StatelessWidget {
  final String postsCount;
  final String likesCount;

  const ProfileImageNameWidget({
    super.key,
    required this.postsCount,
    required this.likesCount,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profile = context.read<ProfileCubit>().currentProfile;

        return Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AvatarWidget(
                avatarPath: profile?.avatar,
                gender: profile?.gender,
                width: 100.w,
                height: 100.h,
                borderRadius: BorderRadius.circular(16.r),
              ),
              SizedBox(height: 14.h),
              Text(
                profile?.name ??
                    (state is ProfileLoading ? "Loading..." : "User"),
                style: AppTextStyles.title20Bold,
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).postsCountLabel(int.tryParse(postsCount) ?? 0),
                    style: AppTextStyles.body16Medium.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                  SizedBox(width: 24.w),
                  Row(
                    children: [
                      const CustomHeartItem(),
                      SizedBox(width: 8.w),
                      Text(
                        likesCount,
                        style: AppTextStyles.body16Medium.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
