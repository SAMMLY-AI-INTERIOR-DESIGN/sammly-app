import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/features/Auth/cubit/auth_cubit.dart';
import 'package:sammly/features/Auth/data/repo/auth_repo.dart';
import 'package:sammly/features/Auth/presentation/views/login_view.dart';
import 'package:sammly/features/Auth/presentation/views/signup_view.dart';
import 'package:sammly/features/Auth/presentation/views/verfictionofsign.dart';
import 'package:sammly/features/favorite/presentation/views/favorite_view.dart';
import 'package:sammly/features/generate/presentation/views/image_generation_stepper_view.dart';
import 'package:sammly/features/generate/presentation/views/remove_view.dart';
import 'package:sammly/features/home/presentation/views/home_view.dart';
import 'package:sammly/features/generate/presentation/views/full_home_view.dart';
import 'package:sammly/features/generate/presentation/views/generate_result_view.dart';
import 'package:sammly/features/generate/presentation/views/restyle_view.dart';
import 'package:sammly/features/generate_loading/presentation/views/generate_loading_view.dart';
import 'package:sammly/features/generate/presentation/views/text_to_image_generate_view.dart';
import 'package:sammly/features/layout/presentation/views/layout_view.dart';
import 'package:sammly/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:sammly/features/profile/presentation/views/edit_profile_view.dart';
import 'package:sammly/features/following/presentation/following_view.dart';
import 'package:sammly/features/profile/presentation/views/my_profile_view.dart';
import 'package:sammly/features/notifications/presentation/notifications_view.dart';
import 'package:sammly/features/profile/presentation/views/privacy_policy_view.dart';
import 'package:sammly/features/profile/presentation/views/profile_view.dart';
import 'package:sammly/features/profile/presentation/views/terms_conditions_view.dart';
import 'package:sammly/features/splash/presentation/splash_view.dart';
import 'package:sammly/features/support/presentation/views/support_view.dart';
import 'package:sammly/features/profile/presentation/views/security_view.dart';
import 'package:sammly/features/Auth/presentation/views/change_password_view.dart';
import 'package:sammly/features/Explore/presentation/views/browse_design_details_view.dart';
import 'package:sammly/features/Explore/presentation/views/shared_design_details_view.dart';
import 'package:sammly/features/Explore/presentation/views/user_profile_view.dart';
import 'package:sammly/features/subscrition/presentation/views/subscription_view.dart';
import 'package:sammly/features/Explore/presentation/views/choose_room.dart' as choose_room;

abstract class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeView:
        return MaterialPageRoute(
          builder: (context) {
            return const HomeView();
          },
        );

      case AppRoutes.splashView:
        return MaterialPageRoute(
          builder: (context) {
            return const SplashScreen();
          },
        );

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

      case AppRoutes.onboardingView:
        return MaterialPageRoute(
          builder: (context) {
            return const OnboardingView();
          },
        );

      case AppRoutes.favoriteView:
        return MaterialPageRoute(
          builder: (context) {
            return const FavoriteView();
          },
        );

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

      case AppRoutes.changePasswordView:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => AuthCubit(AuthRepo()),
              child: const ChangePasswordView(),
            );
          },
        );

      case AppRoutes.browseDesignDetailsView:
        final designId = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (context) {
            return BrowseDesignDetailsView(designId: designId);
          },
        );

      case AppRoutes.sharedDesignDetailsView:
        final designId = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (context) {
            return SharedDesignDetailsView(designId: designId);
          },
        );

      case AppRoutes.profileView:
        return MaterialPageRoute(
          builder: (context) {
            return const ProfileView();
          },
        );

      case AppRoutes.myProfileView:
        return MaterialPageRoute(
          builder: (context) {
            return const MyProfileView();
          },
        );

      case AppRoutes.editProfileView:
        return MaterialPageRoute(
          builder: (context) {
            return const EditProfileView();
          },
        );

      case AppRoutes.followingView:
        return MaterialPageRoute(
          builder: (context) {
            return const FollowingView();
          },
        );

      case AppRoutes.notificationsView:
        return MaterialPageRoute(
          builder: (context) {
            return const NotificationsView();
          },
        );

      case AppRoutes.termsView:
        return MaterialPageRoute(
          builder: (context) {
            return const TermsConditionsView();
          },
        );

      case AppRoutes.privacyView:
        return MaterialPageRoute(
          builder: (context) {
            return const PrivacyPolicyView();
          },
        );

      case AppRoutes.supportView:
        return MaterialPageRoute(
          builder: (context) {
            return const SupportScreen();
          },
        );

      case AppRoutes.securityView:
        return MaterialPageRoute(
          builder: (context) {
            return const SecurityView();
          },
        );

      case AppRoutes.userProfileView:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (context) {
            return UserProfileView(
              userName: args['userName'] ?? 'User',
              userAvatar: args['userAvatar'],
              userId: args['userId'] ?? '',
            );
          },
        );

      case AppRoutes.generateLoadingView:
      final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) {
            return GenerationLoadingWrapper(arguments: args,);
          },
        );

      case AppRoutes.textToImageGenerateView:
        return MaterialPageRoute(
          builder: (context) {
            return const TextToImageGenerateView();
          },
        );

      case AppRoutes.restyleView:
        return MaterialPageRoute(
          builder: (context) {
            return const RestyleView();
          },
        );

      case AppRoutes.removeView:
        return MaterialPageRoute(
          builder: (context) {
            return const RemoveView();
          },
        );

      case AppRoutes.imageGenerationStepperView:
        return MaterialPageRoute(
          builder: (context) {
            return const ImageGenerationStepperView();
          },
        );

      case AppRoutes.fullHomeView:
        return MaterialPageRoute(
          builder: (context) {
            return const FullHomeView();
          },
        );

      case AppRoutes.generateResultView:
        final args = settings.arguments as Map<String, dynamic>?;
        final showListView = args?['showListView'] as bool? ?? false;
        final imageUrl = args?['imageUrl'] as String?;
        final designId = args?['designId'] as String?;
        return MaterialPageRoute(
          builder: (context) {
            return GenerateResultView(
              showListView: showListView,
              networkImageUrl: imageUrl,
              designId: designId,
            );
          },
        );

      case AppRoutes.subscriptionView:
        return MaterialPageRoute(
          builder: (context) {
            return const SubscriptionView();
          },
        );

      case AppRoutes.chooseRoom:
        return MaterialPageRoute(
          builder: (context) {
            return const choose_room.ExploreView(); 
          },
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text('No routes defined for ${settings.name}')),
          ),
        );
    }
  }
}
