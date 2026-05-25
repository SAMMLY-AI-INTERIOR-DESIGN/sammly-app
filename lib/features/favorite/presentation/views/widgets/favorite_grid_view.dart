import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sammly/features/favorite/presentation/views/widgets/favorite_heart_item.dart';
import 'package:sammly/core/routing/routes.dart';

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

  // Heights to simulate staggered look (will come from DB in future)
  final List<double> _itemHeights = [
    1.2,  // tall
    0.85, // short
    1.4,  // taller
    0.9,  // short
    1.0,  // medium
    1.3,  // tall
    0.8,  // short
    1.1,  // medium
  ];

  @override
  Widget build(BuildContext context) {
    final baseWidth = (MediaQuery.of(context).size.width - 44.w) / 2;

    return Expanded(
      child: MasonryGridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        itemCount: _designImageUrls.length,
        itemBuilder: (context, index) {
          final itemHeight = baseWidth * _itemHeights[index % _itemHeights.length];

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.designDetailsView,
                arguments: _designImageUrls[index],
              );
            },
            child: SizedBox(
              height: itemHeight,
              child: FavoriteHeartItem(
                imageUrl: _designImageUrls[index],
                initialIsLiked: true,
              ),
            ),
          );
        },
      ),
    );
  }
}