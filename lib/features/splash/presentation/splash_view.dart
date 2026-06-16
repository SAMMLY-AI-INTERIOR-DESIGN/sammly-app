import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/routing/routes.dart';

// ─── Crop ratios from actual SVG clipPath bounds (all on 1500×1500 canvas) ────
//  logo_roof.svg   : y 477.98→1021.73  contentRatio = 543.75/1500 = 0.3625
//  logo_sammly.svg : y 534.89→965.39   contentRatio = 430.50/1500 = 0.2870
//  logo_word.svg   : y 704.15→795.65   contentRatio =  91.50/1500 = 0.0610
//  All content is centered at y≈750 → Alignment.center trims both bands equally.

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  // ── SAMMLY: 0.0s – 0.5s  (fade + scale settle) ────────────────────────────
  late final Animation<double> _sammlyFade;
  late final Animation<double> _sammlyScale;

  // ── Roof: 0.4s – 0.8s  (fade + scale up) ──────────────────────────────────
  late final Animation<double> _roofFade;
  late final Animation<double> _roofScale;

  // ── Word: 0.6s – 1.0s  (fade + slide up) ──────────────────────────────────
  late final Animation<double> _wordFade;
  late final Animation<double> _wordSlide;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();

    // Single controller for the entire 1.0s sequence
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // ── 1 · SAMMLY  (0.0 → 0.5) ─────────────────────────────────────────────
    _sammlyFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _sammlyScale = Tween<double>(begin: 1.06, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
      ),
    );

    // ── 2 · Roof  (0.4 → 0.8) ───────────────────────────────────────────────
    _roofFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
      ),
    );
    _roofScale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    // ── 3 · Word  (0.6 → 1.0) ───────────────────────────────────────────────
    _wordFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
      ),
    );
    _wordSlide = Tween<double>(begin: 8, end: 0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _runSequence();
  }

  Future<void> _runSequence() async {
    // Small initial pause
    await Future.delayed(const Duration(milliseconds: 200));

    // Play the 1.0s entrance sequence
    await _ctrl.forward();

    // Hold phase: all elements static
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.loginView);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  /// Renders [child] (a square SVG of size [svgWidth]×[svgWidth]) but clips it
  /// to only show the center band where the actual logo content lives.
  /// [contentRatio] = contentHeightPx / 1500 (the SVG canvas size).
  Widget _cropped({
    required double svgWidth,
    required double contentRatio,
    required Widget child,
  }) {
    return ClipRect(
      child: SizedBox(
        width: svgWidth,
        height: svgWidth * contentRatio,
        child: OverflowBox(
          maxWidth: svgWidth,
          maxHeight: svgWidth, // let the SVG render at full square size
          alignment:
              Alignment.center, // content is centered → trim equally top/bottom
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [AppColors.bg1Color, AppColors.bg2Color],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _ctrl,
            builder: (_, __) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── 1 · Roof (fades in + scales up, 0.4–0.8s) ──────────────
                Transform.translate(
                  offset: const Offset(0, 18),
                  child: Opacity(
                    opacity: _roofFade.value,
                    child: Transform.scale(
                      scale: _roofScale.value,
                      alignment: Alignment.bottomCenter,
                      child: _cropped(
                        svgWidth: 220.w,
                        contentRatio: 0.3625,
                        child: SvgPicture.asset(
                          'assets/images/logo_roof.svg',
                          width: 220.w,
                        ),
                      ),
                    ),
                  ),
                ),

                // ── 2 · SAMMLY (fades in + settles, 0.0–0.5s) ──────────────
                Opacity(
                  opacity: _sammlyFade.value,
                  child: Transform.scale(
                    scale: _sammlyScale.value,
                    child: _cropped(
                      svgWidth: 220.w,
                      contentRatio: 0.2870,
                      child: SvgPicture.asset(
                        'assets/images/logo_sammly.svg',
                        width: 220.w,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 6.h),

                // ── 3 · Word / tagline (fades in + slides up, 0.6–1.0s) ────
                Opacity(
                  opacity: _wordFade.value,
                  child: Transform.translate(
                    offset: Offset(0, _wordSlide.value),
                    child: _cropped(
                      svgWidth: 220.w,
                      contentRatio: 0.0610,
                      child: SvgPicture.asset(
                        'assets/images/logo_word.svg',
                        width: 220.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
