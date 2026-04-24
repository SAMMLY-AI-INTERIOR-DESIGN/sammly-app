import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/features/Auth/presentation/views/login_view.dart';

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
    with TickerProviderStateMixin {
  late final AnimationController _roofCtrl;
  late final AnimationController _sammlyCtrl;
  late final AnimationController _wordCtrl;

  late final Animation<double> _roofSlide;
  late final Animation<double> _roofFade;
  late final Animation<double> _sammlyScale;
  late final Animation<double> _sammlyFade;
  late final Animation<double> _wordSlide;
  late final Animation<double> _wordFade;

  // ── Timing ──────────────────────────────────────────────────────────────────
  static const _roofDur = Duration(milliseconds: 1000); // snappy bounce
  static const _textDur = Duration(milliseconds: 350); // quick text reveal

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();

    // ── Controllers ──────────────────────────────────────────────────────────
    _roofCtrl = AnimationController(vsync: this, duration: _roofDur);
    _sammlyCtrl = AnimationController(vsync: this, duration: _textDur);
    _wordCtrl = AnimationController(vsync: this, duration: _textDur);

    // ── Roof bounce: fast drop → slam → bounce → settle ──────────────────────
    // Final rest = +18  → close to SAMMLY with breathing room
    _roofSlide = TweenSequence<double>([
      // 1) Free-fall: -180 → +36  (slam past the target)
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: -180,
          end: 36,
        ).chain(CurveTween(curve: Curves.easeInQuad)),
        weight: 30,
      ),
      // 2) 1st recoil: +36 → +4  (spring back up)
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 36,
          end: 4,
        ).chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 16,
      ),
      // 3) 2nd drop: +4 → +26
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 4,
          end: 26,
        ).chain(CurveTween(curve: Curves.easeInQuad)),
        weight: 14,
      ),
      // 4) 2nd recoil: +26 → +13
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 26,
          end: 13,
        ).chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 12,
      ),
      // 5) 3rd tap: +13 → +22
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 13,
          end: 22,
        ).chain(CurveTween(curve: Curves.easeInQuad)),
        weight: 10,
      ),
      // 6) Settle: +22 → +18  (final rest)
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 22,
          end: 18,
        ).chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 18,
      ),
    ]).animate(_roofCtrl);

    // Fade in fast during the initial fall so it's visible for the impact
    _roofFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _roofCtrl,
        curve: const Interval(0.0, 0.20, curve: Curves.easeIn),
      ),
    );

    // ── SAMMLY & word: quick fade-in (they appear BEFORE the roof drops) ─────
    _sammlyScale = Tween<double>(
      begin: 0.85,
      end: 1,
    ).animate(CurvedAnimation(parent: _sammlyCtrl, curve: Curves.easeOutBack));
    _sammlyFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _sammlyCtrl, curve: Curves.easeIn));
    _wordSlide = Tween<double>(
      begin: 10,
      end: 0,
    ).animate(CurvedAnimation(parent: _wordCtrl, curve: Curves.easeOutCubic));
    _wordFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _wordCtrl, curve: Curves.easeIn));

    _runSequence();
  }

  Future<void> _runSequence() async {
    await Future.delayed(const Duration(milliseconds: 200));

    // 1) Show SAMMLY text first so the roof has something to land on
    _sammlyCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 100));

    // 2) Show tagline right after
    _wordCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 200));

    // 3) NOW drop the roof onto the visible text – bounce & settle
    await _roofCtrl.forward();

    // Hold the finished logo on-screen
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  @override
  void dispose() {
    _roofCtrl.dispose();
    _sammlyCtrl.dispose();
    _wordCtrl.dispose();
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.bg1Color, AppColors.bg2Color],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── 1 · Roof (drops onto the text below) ──────────────────────
              AnimatedBuilder(
                animation: _roofCtrl,
                builder: (_, __) => Transform.translate(
                  offset: Offset(0, _roofSlide.value),
                  child: Opacity(
                    opacity: _roofFade.value,
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

              // ── 2 · SAMMLY (appears first, roof lands on this) ────────────
              AnimatedBuilder(
                animation: _sammlyCtrl,
                builder: (_, __) => Transform.scale(
                  scale: _sammlyScale.value,
                  child: Opacity(
                    opacity: _sammlyFade.value,
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
              ),

              SizedBox(height: 6.h),

              // ── 3 · Word / tagline ────────────────────────────────────────
              AnimatedBuilder(
                animation: _wordCtrl,
                builder: (_, __) => Transform.translate(
                  offset: Offset(0, _wordSlide.value),
                  child: Opacity(
                    opacity: _wordFade.value,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
