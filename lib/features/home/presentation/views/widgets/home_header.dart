import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_state.dart';
import 'package:sammly/features/layout/presentation/cubit/layout_cubit/layout_cubit.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profile = context.read<ProfileCubit>().currentProfile;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  context.read<LayoutCubit>().changeIndex(3);
                },
                borderRadius: BorderRadius.circular(30),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.activeNavBarBg,
                  child: ClipOval(
                    child: profile?.avatar != null
                        ? Image.network(
                            profile!.avatar!,
                            width: 65.w,
                            height: 65.h,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                SvgPicture.asset(
                                  AppImages.maleProfilePlaceholder,
                                  width: 65.w,
                                  height: 65.h,
                                  fit: BoxFit.cover,
                                ),
                          )
                        : SvgPicture.asset(
                            AppImages.maleProfilePlaceholder,
                            width: 65.w,
                            height: 65.h,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: AppTextStyles.title18SemiBold,
                        children: [
                          TextSpan(text: '${AppStrings.greetingPrefix} '),
                          TextSpan(
                            text: profile?.name ?? 'Broo',
                            style: AppTextStyles.title18SemiBold,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.subtitle,
                      style: AppTextStyles.badge14SemiBold.copyWith(
                        color: const Color.fromARGB(255, 122, 145, 154),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: AppColors.tokensColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star,
                      color: AppColors.starColor,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '3',
                      style: AppTextStyles.badge14SemiBold.copyWith(
                        color: AppColors.starColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
