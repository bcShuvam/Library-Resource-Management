import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:library_resource_management/app/modules/dashboard/screen/dashboard_screen.dart';
import 'package:library_resource_management/app/modules/profile/profile_screen.dart';

import '../app/modules/login/login_screen.dart';
import 'app_route_names.dart';

GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  // initialLocation: FirebaseAuth.instance.currentUser != null ? '/login' : '/user_dashboard',
  routes: <RouteBase>[
    GoRoute(
      path: '/login',
      name: AppRouteName.loginRouteName,pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        // transitionDuration: const Duration(milliseconds: 1000),
        fullscreenDialog: true,
        child: LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(
              curve: Curves.easeInOutCirc,
            ).animate(animation),
            child: child,
          );
        },
      );
    },
    ),
    GoRoute(
      path: '/user_dashboard',
      name: AppRouteName.userDashboardRouteName,
      pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        // transitionDuration: const Duration(milliseconds: 1000),
        fullscreenDialog: true,
        child: DashboardScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(
              curve: Curves.easeInOutCirc,
            ).animate(animation),
            child: child,
          );
        },
      );
    },
    ),
    GoRoute(
      path: '/user_profile',
      name: AppRouteName.userProfileRouteName,
      pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        // transitionDuration: const Duration(milliseconds: 1000),
        fullscreenDialog: true,
        child: ProfileScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(
              curve: Curves.easeInOutCirc,
            ).animate(animation),
            child: child,
          );
        },
      );
    },
    ),
  ],
);
