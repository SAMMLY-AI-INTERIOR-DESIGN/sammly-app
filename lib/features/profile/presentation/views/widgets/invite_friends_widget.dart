import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/functions.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/features/profile/presentation/views/widgets/share_link_text_field.dart';
import 'package:sammly/features/profile/presentation/views/widgets/social_icon_widget.dart';
import 'package:sammly/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class InviteFriendsDialog extends StatefulWidget {
  const InviteFriendsDialog({super.key});

  @override
  State<InviteFriendsDialog> createState() => _InviteFriendsDialogState();
}

class _InviteFriendsDialogState extends State<InviteFriendsDialog> {
  late final TextEditingController linkController;

  @override
  void initState() {
    super.initState();
    linkController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (linkController.text.isEmpty) {
      linkController.text = S.of(context).dummyInviteLink;
    }
  }

  @override
  void dispose() {
    linkController.dispose();
    super.dispose();
  }

  String _getCleanLink() {
    return linkController.text.replaceAll('\n', '');
  }

  Future<void> _launchSocialShare(String url) async {
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Could not launch $uri: $e');
    }
  }

  void _shareOnWhatsApp() {
    final link = _getCleanLink();
    final encodedText = Uri.encodeComponent(
      'Check out SAMMLY - AI Interior Design! $link',
    );
    _launchSocialShare('https://wa.me/?text=$encodedText');
  }

  void _shareOnFacebook() {
    final link = _getCleanLink();
    final encodedLink = Uri.encodeComponent(link);
    _launchSocialShare(
      'https://www.facebook.com/sharer/sharer.php?u=$encodedLink',
    );
  }

  void _shareOnX() {
    final link = _getCleanLink();
    final encodedText = Uri.encodeComponent(
      'Check out SAMMLY - AI Interior Design! $link',
    );
    _launchSocialShare('https://twitter.com/intent/tweet?text=$encodedText');
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsetsDirectional.only(
          start: 24.w,
          end: 24.w,
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
              alignment: AlignmentDirectional.topEnd,
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
              S.of(context).inviteFriends,
              style: AppTextStyles.title18SemiBold,
            ),

            SizedBox(height: 16.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                S.of(context).inviteFriendsDesc,
                textAlign: TextAlign.center,
                style: AppTextStyles.body14Regular,
              ),
            ),

            SizedBox(height: 24.h),

            ShareLinkTextField(
              controller: linkController,
              onCopyTap: () {
                Clipboard.setData(ClipboardData(text: _getCleanLink()));
                showCustomSnackBar(
                  context: context,
                  message: S.of(context).linkCopied,
                );
              },
            ),

            SizedBox(height: 24.h),

            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                S.of(context).orShareOn,
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
                  onTap: _shareOnWhatsApp,
                ),
                SizedBox(width: 24.w),
                SocialIconWidget(
                  iconPath: AppImages.facebookicon,
                  onTap: _shareOnFacebook,
                ),
                SizedBox(width: 24.w),
                SocialIconWidget(
                  iconPath: AppImages.xTwitter,
                  onTap: _shareOnX,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
