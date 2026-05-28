import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/theme/text_styles.dart';
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
                child: profile?.avatar != null
                    ? Image.network(
                        profile!.avatar!,
                        width: 100.w,
                        height: 100.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                      Image.network(
                    "https://i.pravatar.cc/150?img=11",
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                  ),
                )
              : Image.network(
                  "https://i.pravatar.cc/150?img=11",
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                ),
        ),
              SizedBox(height: 14.h,),
              Text(
                profile?.name ?? (state is ProfileLoading ? "Loading..." : "User"), 
                style: AppTextStyles.title20Bold,
              ),
              SizedBox(height: 14.h,),
            ],
          ),
        );
      },
    );
  }
}
