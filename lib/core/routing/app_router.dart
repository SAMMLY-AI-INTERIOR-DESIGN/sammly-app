import 'package:flutter/material.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/features/Auth/presentation/views/login_view.dart';
import 'package:sammly/features/Auth/presentation/views/signup_view.dart';
import 'package:sammly/features/layout/presentation/views/layout_view.dart';
import 'package:sammly/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:sammly/features/splash/presentation/splash_view.dart';

abstract class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case AppRoutes.homeView:
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return const HomeView();
      //     },
      //   );

      case AppRoutes.splashView:
        return MaterialPageRoute(
          builder: (context) {
            return const SplashScreen();
          },
        );

      case AppRoutes.loginView:
        return MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        );

      case AppRoutes.registerView:
        return MaterialPageRoute(
          builder: (context) {
            return const SignUpScreen();
          },
        );

      case AppRoutes.layoutView:
        return MaterialPageRoute(
          builder: (context) {
            return const LayoutView();
          },
        );

      case AppRoutes.onboardingView:
        return MaterialPageRoute(
          builder: (context) {
            return const OnboardingView();
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
