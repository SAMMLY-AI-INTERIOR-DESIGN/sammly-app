// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sammly/core/constant/app_colors.dart';
// import 'package:sammly/features/favorite/data/models/favorite_item_model.dart';

// class FavoriteGridItem extends StatelessWidget {
//   final FavoriteItemModel item;
//   final VoidCallback onFavoriteTap;
//   final int index;

//   const FavoriteGridItem({
//     super.key,
//     required this.item,
//     required this.onFavoriteTap,
//     required this.index,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final double height = (index % 3 == 0) ? 250.h : ((index % 2 == 0) ? 200.h : 300.h);

//     return Container(
//       height: height,
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(16.r),
//             child: Container(
//               color: AppColors.bg1Color,
//               child: SvgPicture.asset(
//                 item.imagePath,
//                 fit: BoxFit.scaleDown,
//                 width: double.infinity,
//                 height: double.infinity,
//               ),
//             ),
//           ),

//           Positioned(
//             top: 16.h,
//             right: 12.w,
//             child: GestureDetector(
//               onTap: onFavoriteTap,
//               child: ShaderMask(
//                 blendMode: BlendMode.srcIn,
//                 shaderCallback: (bounds) {
//                   return AppColors.primaryGradient3.createShader(bounds);
//                 },
//                 child: Icon(
//                     item.isFavorite ? Icons.favorite : Icons.favorite_border,
//                     color: Colors.white,
//                     size: 20.sp,
//                   ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';

class FavoriteHeartItem extends StatefulWidget {
  final String designId;
  final String imageUrl;
  final bool initialIsLiked;
  final Function(bool isLiked)? onFavoriteToggled;

  const FavoriteHeartItem({
    super.key,
    required this.designId,
    required this.imageUrl,
    this.initialIsLiked = false,
    this.onFavoriteToggled,
  });

  @override
  State<FavoriteHeartItem> createState() => _FavoriteHeartItemState();
}

class _FavoriteHeartItemState extends State<FavoriteHeartItem> {
  late bool _isLiked;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.initialIsLiked;
  }
  
  @override
  void didUpdateWidget(FavoriteHeartItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialIsLiked != oldWidget.initialIsLiked) {
      _isLiked = widget.initialIsLiked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            widget.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: AppColors.greyColor.withValues(alpha: 0.2),
                child: Icon(
                  Icons.broken_image,
                  color: AppColors.greyColor.withValues(alpha: 0.5),
                  size: 30.sp,
                ),
              );
            },
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.blackColor.withValues(alpha: 0.3),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.3],
              ),
            ),
          ),

          Positioned(
            top: 12.h,
            right: 6.w,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isLiked = !_isLiked;
                });
                if (widget.onFavoriteToggled != null) {
                  widget.onFavoriteToggled!(_isLiked);
                }
              },
              child: Container(
                padding: EdgeInsets.all(6.w),
                decoration: const BoxDecoration(
                  color: AppColors.bg2Color,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isLiked ? Icons.bookmark : Icons.bookmark_border,
                  color: AppColors.primaryColor,
                  size: 20.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
