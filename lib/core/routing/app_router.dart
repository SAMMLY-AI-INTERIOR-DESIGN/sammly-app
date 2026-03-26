// import 'package:flutter/material.dart';
// import 'package:sammly/core/routing/routes.dart';

// abstract class AppRouter {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case AppRoutes.homeView:
//         return MaterialPageRoute(
//           builder: (context) {
//             return const HomeView();
//           },
//         );

//       case AppRoutes.loginView:
//         return MaterialPageRoute(
//           builder: (context) {
//             return const SignInView();
//           },
//         );

//       case AppRoutes.registerView:
//         return MaterialPageRoute(
//           builder: (context) {
//             return const SignUpView();
//           },
//         );

//       case AppRoutes.layoutView:
//         return MaterialPageRoute(
//           builder: (context) {
//             return const LayoutNavbarView();
//           },
//         );

//       case AppRoutes.splashView:
//         return MaterialPageRoute(
//           builder: (context) {
//             return const SplashView();
//           },
//         );

//       case AppRoutes.profileView:
//         return MaterialPageRoute(
//           builder: (context) {
//             return const ProfileView();
//           },
//         );

//       default:
//         return MaterialPageRoute(
//           builder: (context) => Scaffold(
//             body: Center(child: Text('No routes defined for ${settings.name}')),
//           ),
//         );
//     }
//   }
// }
