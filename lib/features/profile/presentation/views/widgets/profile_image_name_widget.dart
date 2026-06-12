import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/avatar_widget.dart';
import 'package:sammly/core/widgets/custom_heart_item.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_state.dart';

class ProfileImageNameWidget extends StatelessWidget {
  const ProfileImageNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profile = context.read<ProfileCubit>().currentProfile;

        return Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              ClipRRect(
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
                children: [
                  Text("23 post", style: AppTextStyles.body14Regular),
                  SizedBox(width: 24.w),
                  Row(
                    children: [
                      const CustomHeartItem(),
                      SizedBox(width: 4.w),
                      Text("120", style: AppTextStyles.body14Regular),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 14.h),
            ],
          ),
        );
      },
    );
  }
}
