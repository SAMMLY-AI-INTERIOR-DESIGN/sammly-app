import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/features/Auth/cubit/auth_cubit.dart';
import 'package:sammly/features/Auth/data/repo/auth_repo.dart';
import 'package:sammly/features/Auth/presentation/views/login_view.dart';
import 'package:sammly/features/Auth/presentation/views/signup_view.dart';
import 'package:sammly/features/Auth/presentation/views/verfictionofsign.dart';
// import 'package:sammly/features/favorite/presentation/views/favorite_view.dart';
import 'package:sammly/features/layout/presentation/views/layout_view.dart';
// import 'package:sammly/features/onboarding/presentation/views/onboarding_view.dart';
// import 'package:sammly/features/splash/presentation/splash_view.dart';

abstract class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case AppRoutes.homeView:
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return const HomeView();
      //     },
      //   );

      // case AppRoutes.splashView:
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return const SplashScreen();
      //     },
      //   );

      case AppRoutes.loginView:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => AuthCubit(AuthRepo()),
              child: const LoginScreen(),
            );
          },
        );

      case AppRoutes.registerView:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => AuthCubit(AuthRepo()),
              child: const SignUpScreen(),
            );
          },
        );

      case AppRoutes.layoutView:
        return MaterialPageRoute(
          builder: (context) {
            return const LayoutView();
          },
        );

      // case AppRoutes.onboardingView:
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return const OnboardingView();
      //     },
      //   );

      // case AppRoutes.favoriteView:
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return const FavoriteView();
      //     },
      //   );

      case AppRoutes.verificationView:
        final email = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => AuthCubit(AuthRepo()),
              child: SignUpVerificationView(email: email),
            );
          },
        );

      // case AppRoutes.profileView:
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return const ProfileView();
      //     },
      //   );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text('No routes defined for ${settings.name}')),
          ),
        );
    }
  }
}
