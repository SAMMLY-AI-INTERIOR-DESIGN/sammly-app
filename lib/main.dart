import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_preview/device_preview.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/routing/app_router.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize networking and local storage
  DioHelper.init();
  await SharedPref.init();

  runApp(
    DevicePreview(enabled:false //!kReleaseMode
    , builder: (context) => const SammlyApp()),
  );
}

class SammlyApp extends StatelessWidget {
  const SammlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          initialRoute: AppRoutes.splashView,
          onGenerateRoute: AppRouter.generateRoute,
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true, // ضروري لـ DevicePreview
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          title: 'Sammly',

        );
      },
    );
  }
}