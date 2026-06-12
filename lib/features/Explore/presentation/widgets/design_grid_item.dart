import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_toggle_cubit.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_toggle_state.dart';

class DesignGridItem extends StatelessWidget {
  final String imageUrl;
  final String designId;
  final bool showLikeButton;

  const DesignGridItem({
    super.key,
    required this.imageUrl,
    required this.designId,
    this.showLikeButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: Icon(
                  Icons.broken_image,
                  color: Colors.grey,
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
                colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                stops: const [0.0, 0.3],
              ),
            ),
          ),

          if (showLikeButton)
            Positioned(
              top: 8.h,
              right: 8.w,
              child: BlocBuilder<FavoriteToggleCubit, FavoriteToggleState>(
                buildWhen: (prev, curr) {
                  if (curr is FavoriteToggleUpdated) {
                    return curr.designId == designId;
                  }
                  if (curr is FavoriteToggleReverted) {
                    return curr.designId == designId;
                  }
                  return false;
                },
                builder: (context, state) {
                  final isLiked = context
                      .read<FavoriteToggleCubit>()
                      .isFavorited(designId);

                  return GestureDetector(
                    onTap: () {
                      context
                          .read<FavoriteToggleCubit>()
                          .toggleFavorite(designId);
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: const BoxDecoration(
                        color: AppColors.bg2Color,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        isLiked
                            ? AppImages.withsaving
                            : AppImages.withoutsaving,
                        width: 19.w,
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
