import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/features/subscrition/cubit/subscription_cubit.dart';
import 'package:sammly/features/subscrition/cubit/subscription_states.dart';
import 'package:sammly/features/subscrition/data/subscription_repo.dart';
import 'package:sammly/features/subscrition/presentation/views/widgets/custom_plan.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/functions.dart';
import 'package:sammly/generated/l10n.dart';

class SubscriptionView extends StatefulWidget {
  const SubscriptionView({super.key});

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  int _selectedPlanIndex = 1;

  // Maps plan index to backend packageId
  String _getPackageId(int index) {
    switch (index) {
      case 0:
        return 'free';
      case 1:
        return 'starter';
      case 2:
        return 'pro';
      case 3:
        return 'premium';
      default:
        return 'starter';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubscriptionCubit(SubscriptionRepo())..getPackages(),
      child: BlocConsumer<SubscriptionCubit, SubscriptionState>(
        listener: (context, state) {
          if (state is ClaimSuccess) {
            final result = state.result;
            // Show success message
            showCustomSnackBar(
              context: context,
              message: result.tokens != null
                  ? '${result.message} (${S.of(context).tokens}: ${result.tokens})'
                  : result.message,
              isError: false,
            );
          } else if (state is ClaimFailure) {
            showCustomSnackBar(
              context: context,
              message: state.error,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          final claimingPackageId = state is SubscriptionLoading ? state.packageId : null;
          final isPackagesLoading = state is PackagesLoading || (state is SubscriptionInitial && context.read<SubscriptionCubit>().packagesList.isEmpty);

          return Scaffold(
            backgroundColor: AppColors.whiteColor,
            body: Column(
              children: [
                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Background Image + Logo + Title
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Background image - show full, not zoomed
                            ShaderMask(
                              shaderCallback: (rect) {
                                return const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.black, Colors.transparent],
                                  stops: [0.5, 1.0],
                                ).createShader(
                                  Rect.fromLTRB(
                                      0, 0, rect.width, rect.height),
                                );
                              },
                              blendMode: BlendMode.dstIn,
                              child: Image.asset(
                                AppImages.subscriptionBgPlaceholder,
                                fit: BoxFit.fitWidth,
                                width: double.infinity,
                              ),
                            ),

                            // Back button
                            PositionedDirectional(
                              top: MediaQuery.of(context).padding.top + 10,
                              start: 20,
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.white.withValues(alpha: 0.85),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withValues(alpha: 0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: AppColors.blackColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),

                            // Logo + Title overlay at bottom of image
                            PositionedDirectional(
                              start: 0,
                              end: 0,
                              bottom: 0,
                              child: Column(
                                children: [
                                  SvgPicture.asset(AppImages.splash,
                                      height: 90),
                                  Text(
                                    S.of(context).sammlyPro,
                                    style: AppTextStyles.heading28ExtraBold
                                        .copyWith(
                                      color: Colors.black,
                                      fontSize: 32.sp,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    S.of(context).pickPerfectPlan,
                                    textAlign: TextAlign.center,
                                    style:
                                        AppTextStyles.body16Regular.copyWith(
                                      color: const Color(0xFF2E2E2E),
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Plans list
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: isPackagesLoading
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 50.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : state is PackagesError
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 50.0),
                                      child: Center(
                                        child: Text(
                                          state.error,
                                          style: const TextStyle(color: Colors.red, fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  : context.read<SubscriptionCubit>().packagesList.isEmpty
                                      ? const Padding(
                                          padding: EdgeInsets.only(top: 50.0),
                                          child: Center(
                                            child: Text(
                                              'No packages available.',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        )
                                      : Column(
                                  children: [
                                    Builder(
                                      builder: (context) {
                                        final packages = context.read<SubscriptionCubit>().packagesList;
                                        PackageModel? getPackage(String id) {
                                          try {
                                            return packages.firstWhere((p) => p.packageId == id);
                                          } catch (_) {
                                            return null;
                                          }
                                        }

                                        final freePkg = getPackage('free');
                                        final starterPkg = getPackage('starter');
                                        final proPkg = getPackage('pro');
                                        final premiumPkg = getPackage('premium');
                                        
                                        final isArabic = Localizations.localeOf(context).languageCode == 'ar';
                                        String currencyText(int price) => isArabic ? 'ج.م $price' : 'EGP $price';

                                        return Column(
                                          children: [
                                            if (freePkg != null)
                                              CustomPlan(
                                                iconPath: AppImages.giftIcon,
                                                title: S.of(context).freeGenerations,
                                                tokensAmount: freePkg.tokens.toString(),
                                                description: S.of(context).planDesc1,
                                                price: S.of(context).free,
                                                primaryColor: const Color(0xFFD97706),
                                                bgColor: const Color(0xFFFFFBEB),
                                                isFree: true,
                                                isSelected: _selectedPlanIndex == 0,
                                                onTap: () =>
                                                    setState(() => _selectedPlanIndex = 0),
                                              ),

                                            if (starterPkg != null)
                                              CustomPlan(
                                                iconPath: AppImages.starIcon,
                                                title: S.of(context).planStarter,
                                                tokensAmount: starterPkg.tokens.toString(),
                                                description: S.of(context).planDesc2,
                                                price: currencyText(starterPkg.price),
                                                priceSub: S.of(context).perPack,
                                                primaryColor: const Color(0xFF3C60B6),
                                                bgColor: const Color(0xFFF1F4FA),
                                                borderColor: const Color(0xFFC0CBE7),
                                                isSelected: _selectedPlanIndex == 1,
                                                onTap: () =>
                                                    setState(() => _selectedPlanIndex = 1),
                                              ),

                                            if (proPkg != null)
                                              CustomPlan(
                                                iconPath: AppImages.crownIcon,
                                                title: S.of(context).planPro,
                                                tokensAmount: proPkg.tokens.toString(),
                                                description: S.of(context).planDesc3,
                                                price: currencyText(proPkg.price),
                                                priceSub: S.of(context).perPack,
                                                primaryColor: const Color(0xFF23B5A0),
                                                bgColor: const Color(0xFFEAFAF7),
                                                isSelected: _selectedPlanIndex == 2,
                                                onTap: () =>
                                                    setState(() => _selectedPlanIndex = 2),
                                              ),

                                            if (premiumPkg != null)
                                              CustomPlan(
                                                iconPath: AppImages.diamondIcon,
                                                title: S.of(context).planPremium,
                                                tokensAmount: premiumPkg.tokens.toString(),
                                                description: S.of(context).planDesc4,
                                                price: currencyText(premiumPkg.price),
                                                priceSub: S.of(context).perPack,
                                                primaryColor: const Color(0xFF8B5CF6),
                                                bgColor: const Color(0xFFF5F0FF),
                                                isSelected: _selectedPlanIndex == 3,
                                                onTap: () =>
                                                    setState(() => _selectedPlanIndex = 3),
                                              ),
                                          ],
                                        );
                                      }
                                    ),
                                  ],
                                ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),

                // Fixed Subscribe Button at bottom
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 20,
                    end: 20,
                    bottom: MediaQuery.of(context).padding.bottom + 16,
                    top: 12,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient3,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ElevatedButton(
                      onPressed: claimingPackageId != null
                          ? null
                          : () {
                              context
                                  .read<SubscriptionCubit>()
                                  .claimPackage(
                                      _getPackageId(_selectedPlanIndex));
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: claimingPackageId == _getPackageId(_selectedPlanIndex)
                          ? SizedBox(
                              width: 24.w,
                              height: 24.w,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : Text(
                              _selectedPlanIndex == 0 
                                  ? S.of(context).getBtn 
                                  : S.of(context).subscribe,
                              style: AppTextStyles.title20Bold.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
