import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/features/favorite/presentation/views/widgets/favorite_heart_item.dart';

class FavoriteGridView extends StatelessWidget {
  FavoriteGridView({super.key});

  final List<String> _designImageUrls = [
    'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?q=80&w=600&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1513694203232-719a280e022f?q=80&w=600&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1616046229478-9901c5536a45?q=80&w=600&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?q=80&w=600&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1617104678098-de229db51175?q=80&w=600&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1634712282287-14ed57b9cc89?q=80&w=600&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?q=80&w=600&auto=format&fit=crop',
    'https://images.unsplash.com/photos/a-bedroom-with-a-bed-and-a-plant-in-the-corner-WxqrvWtbg2o?q=80&w=600&auto=format&fit=crop',
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 1.0,
        ),
        itemCount: _designImageUrls.length,
        itemBuilder: (context, index) {
          return FavoriteHeartItem(imageUrl: _designImageUrls[index]);
        },
      ),
    );
  }
}