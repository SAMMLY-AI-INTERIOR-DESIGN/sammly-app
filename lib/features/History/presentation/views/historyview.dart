import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/features/History/presentation/widgets/customhistory.dart';
import 'package:sammly/features/History/presentation/views/historydetails.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة من الصور المختلفة (أفقي وعمودي) عشان نجرب عليها
    final List<Map<String, String>> historyData = [
      {
        'title': 'Vertical Living Room',
        'imageUrl':
            'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?w=600',
      },
      {
        'title': 'Horizontal Living Room',
        'imageUrl':
            'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=600',
      },
      {
        'title': 'Minimalist Dining',
        'imageUrl':
            'https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?w=600',
      },
      {
        'title': 'Vertical Bedroom',
        'imageUrl':
            'https://images.unsplash.com/photo-1616594039964-ae9021a400a0?w=600',
      },
      {
        'title': 'Cozy Office',
        'imageUrl':
            'https://images.unsplash.com/photo-1524758631624-e2822e304c36?w=600',
      },
      {
        'title': 'Classic Bathroom',
        'imageUrl':
            'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=600',
      },
      {
        'title': 'Bright Sunroom',
        'imageUrl':
            'https://images.unsplash.com/photo-1513694203232-719a280e022f?w=600',
      },
      {
        'title': 'Modern Balcony',
        'imageUrl':
            'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=600',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: const CustomAppbar(title: 'History'),
      body: SafeArea(
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          itemCount: historyData.length,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final item = historyData[index];
            return CustomHistoryContainer(
              imageUrl: item['imageUrl']!,
              title: item['title']!,
              description:
                  'Lorem ipsum dolor sit amet consectetur adipisicing elit',
              date: '9 Feb 2026',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoryDetailsView(
                      title: item['title']!,
                      imageUrl: item['imageUrl']!,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
