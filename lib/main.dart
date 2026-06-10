import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/routing/app_router.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/features/profile/data/repo/profile_repo.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sammly/features/support/cubit/support_cubit.dart';
import 'package:sammly/features/support/data/repo/support_repo.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // WidgetsFlutterBinding.ensureInitialized();
  // Initialize networking and local storage
  DioHelper.init();
  await SharedPref.init();

  runApp(const SammlyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class SammlyApp extends StatelessWidget {
  const SammlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileCubit(ProfileRepo())..fetchProfile(),
        ),
        BlocProvider(create: (context) => SupportCubit(SupportRepo())),
        // NetworkCubit removed for auto-check
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            initialRoute: AppRoutes.splashView,
            onGenerateRoute: AppRouter.generateRoute,
            debugShowCheckedModeBanner: false,
            title: AppStrings.appname,
            theme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: AppColors.whiteColor,
              primaryColor: AppColors.primaryColor,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryColor,
              ),
              progressIndicatorTheme: const ProgressIndicatorThemeData(
                color: AppColors.primaryColor,
              ),
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: AppColors.primaryColor,
                selectionColor: AppColors.activeNavBarBg,
                selectionHandleColor: AppColors.primaryColor,
              ),
              appBarTheme: const AppBarTheme(
                elevation: 0,
                scrolledUnderElevation: 0,
                backgroundColor: AppColors.whiteColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
