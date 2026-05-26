import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/functions.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/features/profile/presentation/views/widgets/share_link_text_field.dart';
import 'package:sammly/features/profile/presentation/views/widgets/social_icon_widget.dart';

class InviteFriendsDialog extends StatelessWidget {
  final TextEditingController linkController = TextEditingController(
    text: AppStrings.dummyInviteLink,
  );

  InviteFriendsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.only(
          left: 24.w,
          right: 24.w,
          top: 16.h,
          bottom: 32.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return AppColors.primaryGradient3.createShader(bounds);
                  },
                  child: Icon(
                    Icons.close,
                    color: AppColors.whiteColor,
                    size: 24.sp,
                  ),
                ),
              ),
            ),

            Text(
              AppStrings.inviteFriends,
              style: AppTextStyles.title18SemiBold,
            ),

            SizedBox(height: 16.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                AppStrings.inviteFriendsDesc,
                textAlign: TextAlign.center,
                style: AppTextStyles.body14Regular,
              ),
            ),

            SizedBox(height: 24.h),

            ShareLinkTextField(
              controller: linkController,
              onCopyTap: () {
                Clipboard.setData(ClipboardData(text: linkController.text));
                showCustomSnackBar(
                  context: context,
                  message: AppStrings.linkCopied,
                );
              },
            ),

            SizedBox(height: 24.h),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppStrings.orShareOn,
                style: AppTextStyles.body14Regular.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ),

            SizedBox(height: 16.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialIconWidget(
                  iconPath: AppImages.whatsapp,
                  onTap: () {},
                ),
                SizedBox(width: 24.w),
                SocialIconWidget(
                  iconPath: AppImages.facebookicon,
                  onTap: () {},
                ),
                SizedBox(width: 24.w),
                SocialIconWidget(
                  iconPath: AppImages.xTwitter,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  
}
