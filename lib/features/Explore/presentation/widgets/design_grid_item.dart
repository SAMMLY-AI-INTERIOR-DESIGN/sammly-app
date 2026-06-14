import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_images.dart';

class DesignGridItem extends StatefulWidget {
  final String imageUrl;
  final bool initialIsLiked;
  final bool showLikeButton;
  // Callback مفيد جداً لشاشة المفضلات عشان تعرف لو اليوزر شال اللايك
  final Function(bool isLiked)? onFavoriteToggled;

  const DesignGridItem({
    super.key,
    required this.imageUrl,
    this.initialIsLiked = false,
    this.showLikeButton = true,
    this.onFavoriteToggled,
  });

  @override
  State<DesignGridItem> createState() => _DesignGridItemState();
}

class _DesignGridItemState extends State<DesignGridItem> {
  late bool _isLiked;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.initialIsLiked;
  }

  @override
  void didUpdateWidget(DesignGridItem oldWidget) {
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
          // الصورة الأساسية
          widget.imageUrl.isEmpty
              ? Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 30.sp,
                    ),
                  ),
                )
              : Image.network(
                  widget.imageUrl,
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

          // تدرج لوني خفيف فوق الصورة عشان القلب الأبيض يبان لو الصورة فاتحة
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

          // أيقونة القلب
          if (widget.showLikeButton)
            Positioned(
              top: 8.h,
              right: 8.w,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isLiked = !_isLiked;
                  });
                  // لو شاشة تانية مستنية تعرف النتيجة، نبعتلها الحالة الجديدة
                  if (widget.onFavoriteToggled != null) {
                    widget.onFavoriteToggled!(_isLiked);
                  }
                },
                child: SvgPicture.asset(
                  _isLiked ? AppImages.withsaving : AppImages.withoutsaving,
                  width: 24.w,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
