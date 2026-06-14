import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sammly/features/home/logic/home_cubit.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:sammly/features/History/cubit/historycubit.dart';
import 'package:sammly/features/Explore/cubit/explorecubit.dart';
import 'package:sammly/features/Explore/cubit/static_designs_cubit.dart';


class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.r),
          topRight: Radius.circular(28.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16.h),
          SvgPicture.asset(AppImages.logOut, width: 30.w, height: 30.h,),
          
          SizedBox(height: 24.h),
          
          Text(
            AppStrings.logoutConfirmMsg,
            textAlign: TextAlign.center,
            style: AppTextStyles.title18SemiBold,
          ),
          
          SizedBox(height: 32.h),
          
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    side: BorderSide(color: AppColors.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                  ),
                  child: Text(
                    AppStrings.cancel,
                    style: AppTextStyles.body16Regular.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              
              SizedBox(width: 16.w),
              
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    // 1. Clear ALL stored data (jwt, userId, cached profile, etc.)
                    await SharedPref.clearAll();

                    // 2. Reset the cubits to prevent state leaks across different accounts.
                    if (context.mounted) {
                      context.read<ProfileCubit>().reset();
                      context.read<HomeCubit>().reset();
                      context.read<FavoriteCubit>().reset();
                      context.read<HistoryCubit>().reset();
                      context.read<ExploreCubit>().reset();
                      context.read<StaticDesignsCubit>().reset();
                    }

                    // 3. Navigate to login and remove all previous routes
                    if (context.mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.loginView,
                        (route) => false,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redColor,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                  ),
                  child: Text(
                    AppStrings.logOut,
                    style: AppTextStyles.body16Regular.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
