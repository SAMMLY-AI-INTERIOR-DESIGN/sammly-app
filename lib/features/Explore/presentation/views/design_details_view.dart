import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';

class DesignDetailsView extends StatefulWidget {
  final String imageUrl;

  const DesignDetailsView({super.key, required this.imageUrl});

  @override
  State<DesignDetailsView> createState() => _DesignDetailsViewState();
}

class _DesignDetailsViewState extends State<DesignDetailsView> {
  bool _isLiked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppbar(
        title: 'Living Room',
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: AppColors.blackColor, size: 24.sp),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Prompt text
              Text(
                'Prompt : Lorem ipsum dolor sit amet consectetur. Fermentum volutpat praesent purus massa neque leo. Gravida sapien non tristique justo non adipiscing sem nam.',
                style: TextStyle(
                  color: AppColors.blackColor.withOpacity(0.8),
                  fontSize: 14.sp,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Manrope',
                ),
              ),
              SizedBox(height: 20.h),

              // Image Container
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Stack(
                  children: [
                    Image.network(
                      widget.imageUrl,
                      width: double.infinity,
                      height: 350.h,
                      fit: BoxFit.cover,
                    ),
                    
                    // Gradient overlay at top for heart
                    Container(
                      height: 80.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),

                    // Gradient overlay at bottom for expand icon
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 80.h,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.3),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Heart Icon
                    Positioned(
                      top: 12.h,
                      right: 12.w,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isLiked = !_isLiked;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: const BoxDecoration(
                            color: AppColors.bg2Color,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            _isLiked ? AppImages.heartFilled : AppImages.heartOutline,
                            width: 20.w,
                          ),
                        ),
                      ),
                    ),

                    // Expand Icon
                    Positioned(
                      bottom: 12.h,
                      right: 12.w,
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.fullscreen,
                          color: AppColors.primaryColor,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),

              // Likes count
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: AppColors.bg2Color,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.primaryColor,
                        size: 14.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '34',
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Manrope',
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 40.h),

              // Bottom Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionButton(
                    title: 'Customize',
                    icon: Icons.auto_awesome,
                    onTap: () {},
                  ),
                  _buildActionButton(
                    title: 'Share',
                    icon: Icons.share_outlined,
                    onTap: () {},
                  ),
                  _buildActionButton(
                    title: 'Download',
                    icon: Icons.cloud_download_outlined,
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({required String title, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 105.w,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F9F9), // Light cyan/blue background from image
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.primaryColor.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.primaryColor,
              size: 24.sp,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                color: AppColors.blackColor.withOpacity(0.8),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Manrope',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
