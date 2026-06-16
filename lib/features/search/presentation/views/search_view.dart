import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/features/search/presentation/widgets/similar_item_card.dart';
import 'package:sammly/generated/l10n.dart';

class SmartLensBottomSheet extends StatelessWidget {
  final List<SimilarItemModel> dummyItems;

  const SmartLensBottomSheet({super.key, required this.dummyItems});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.45, // الحجم المبدئي عند الفتح (نصف الشاشة تقريباً)
      minChildSize: 0.25, // أقل حجم ممكن يوصله عند السحب للأسفل
      maxChildSize:
          0.85, // أقصى حجم يوصله عند السحب للأعلى (ملء الشاشة تقريباً)
      snap: true, // يخليه يقفز أوتوماتيك للمقاسات القريبة بنعومة
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            children: [
              // الـ Notch أو خط السحب العلوي الممسوك من فيجما
              SizedBox(height: 12.h),
              Container(
                width: 48.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF2E2E2E),
                  borderRadius: BorderRadius.circular(2.5.r),
                ),
              ),
              SizedBox(height: 24.h),

              // النصوص الرأسية الثابتة
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).similarItems,
                        style: TextStyle(
                          color: const Color(0xFF2E2E2E),
                          fontSize: 22.sp,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        S.of(context).foundSimilarItems,
                        style: TextStyle(
                          color: const Color(0xFF5B5B5B),
                          fontSize: 14.sp,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // شبكة المنتجات الذكية (2-Column Grid) مع الـ Scroll Controller الخاص بالسحب
              Expanded(
                child: GridView.builder(
                  controller:
                      scrollController, // 💡 ضروري جداً لربط السكرول بالسحب
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 8.h,
                  ),
                  itemCount: dummyItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // عدد الأعمدة (2 كما في التصميم)
                    crossAxisSpacing: 16.w, // المسافات الأفقيـة
                    mainAxisSpacing: 16.h, // المسافات الرأسيـة
                    childAspectRatio: 0.78, // ضبط تناسب الطول مع العرض للكارد
                  ),
                  itemBuilder: (context, index) {
                    return SimilarItemCard(item: dummyItems[index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
