import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/routing/app_router.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/features/home/data/repo/home_repo.dart';
import 'package:sammly/features/home/logic/home_cubit.dart';
import 'package:sammly/features/profile/data/repo/profile_repo.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sammly/features/support/cubit/support_cubit.dart';
import 'package:sammly/features/support/data/repo/support_repo.dart';
import 'package:sammly/features/History/cubit/historycubit.dart';
import 'package:sammly/features/History/data/history_repo.dart';
import 'package:sammly/features/Explore/cubit/explorecubit.dart';
import 'package:sammly/features/Explore/cubit/explorerepo.dart';
import 'package:sammly/features/Explore/cubit/static_designs_cubit.dart';
import 'package:sammly/features/Explore/cubit/static_designs_repo.dart';
import 'package:sammly/features/Explore/cubit/design_details_cubit.dart';
import 'package:sammly/features/Explore/cubit/design_details_repo.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:sammly/features/favorite/data/repo/favorite_repo.dart';
import 'package:sammly/core/localization/locale_cubit.dart';
import 'package:sammly/generated/l10n.dart';

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
          lazy: false,
          create: (context) => ProfileCubit(ProfileRepo())..fetchProfile(),
        ),
        BlocProvider(create: (context) => SupportCubit(SupportRepo())),
        BlocProvider(
          lazy: false,
          create: (context) => HomeCubit(HomeRepo())..fetchHomeData(),
        ),
        BlocProvider(create: (context) => HistoryCubit(HistoryRepo())),
        BlocProvider(create: (context) => ExploreCubit(ExploreRepo())),
        BlocProvider(
          create: (context) => StaticDesignsCubit(StaticDesignsRepo()),
        ),
        BlocProvider(
          create: (context) => DesignDetailsCubit(DesignDetailsRepo()),
        ),
        BlocProvider(create: (context) => FavoriteCubit(FavoriteRepo())),
        BlocProvider(create: (context) => LocaleCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                initialRoute: AppRoutes.splashView,
                onGenerateRoute: AppRouter.generateRoute,
                debugShowCheckedModeBanner: false,
                onGenerateTitle: (context) => S.of(context).appname,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: locale,
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
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness: Brightness.dark,
                      statusBarBrightness: Brightness.light,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
