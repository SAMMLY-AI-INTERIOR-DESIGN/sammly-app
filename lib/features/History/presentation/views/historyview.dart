import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/features/History/presentation/widgets/customhistory.dart';
import 'package:sammly/features/History/presentation/views/historydetails.dart';
import 'package:sammly/features/layout/presentation/cubit/layout_cubit/layout_cubit.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة من الصور المختلفة (أفقي وعمودي) عشان نجرب عليها
    final List<Map<String, String>> historyData = [];

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppbar(
        title: 'History',
        onBack: () => context.read<LayoutCubit>().changeIndex(0),
      ),
      body: SafeArea(
        child: historyData.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.noImage),
                    Text(
                      AppStrings.noHistory,
                      style: AppTextStyles.title20Bold,
                    ),
                    Text(
                      AppStrings.noHistoryDesc,
                      style: AppTextStyles.body16Regular.copyWith(
                        color: AppColors.greyColor.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              )
            : ListView.separated(
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
