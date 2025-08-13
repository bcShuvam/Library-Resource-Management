import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:library_resource_management/app/modules/borrow/screen/borrow_requests_list_screen.dart';
import 'package:library_resource_management/app/modules/catalog/screen/add_item_screen.dart';
import 'package:library_resource_management/app/modules/category/screen/catalog_list_screen.dart';
import 'package:library_resource_management/app/modules/category/screen/category_screen.dart';
import 'package:library_resource_management/app/modules/category/screen/catelog_detail.dart';
import 'package:library_resource_management/app/modules/dashboard/screen/admin_dashboard_screen.dart';
import 'package:library_resource_management/app/modules/dashboard/screen/student_dashboard_screen.dart';
import 'package:library_resource_management/app/modules/profile/screen/profile_screen.dart';
import 'package:library_resource_management/app/modules/request/screen/MyBorrowRequestScreen.dart';
import 'package:library_resource_management/app/modules/splash_screen/splash_screen.dart';

import '../app/modules/login/login_screen.dart';
import 'app_route_names.dart';

GoRouter appRouter = GoRouter(
  initialLocation: '/splash_screen',
  // initialLocation: FirebaseAuth.instance.currentUser != null ? '/login' : '/user_dashboard',
  routes: <RouteBase>[
    GoRoute(
      path: '/splash_screen',
      name: AppRouteName.splashScreenRouteName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: const Duration(milliseconds: 1000),
          fullscreenDialog: true,
          child: SplashScreen(),
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
      path: '/login',
      name: AppRouteName.loginRouteName,
      pageBuilder: (context, state) {
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
      path: '/admin_dashboard',
      name: AppRouteName.adminDashboardRouteName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: const Duration(milliseconds: 1000),
          fullscreenDialog: true,
          child: AdminDashboardScreen(),
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
      path: '/category',
      name: AppRouteName.categoryRouteName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: const Duration(milliseconds: 1000),
          fullscreenDialog: true,
          child: CategoryScreen(),
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
      path: '/add_item',
      name: AppRouteName.addItemRouteName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: const Duration(milliseconds: 1000),
          fullscreenDialog: true,
          child: AddItemScreen(),
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
      path: '/catalog_list',
      name: AppRouteName.catalogListRouteName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: const Duration(milliseconds: 1000),
          fullscreenDialog: true,
          child: CatalogListScreen(),
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
      path: '/catalog_detail',
      name: AppRouteName.catalogDetailRouteName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: const Duration(milliseconds: 1000),
          fullscreenDialog: true,
          child: CatalogDetailScreen(),
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

    //// Student Route
    GoRoute(
      path: '/student_dashboard',
      name: AppRouteName.studentDashboardRouteName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: const Duration(milliseconds: 1000),
          fullscreenDialog: true,
          child: StudentDashboardScreen(),
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
      path: '/profile',
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
    GoRoute(
      path: '/my_borrow',
      name: AppRouteName.myBorrowRequestRouteName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: const Duration(milliseconds: 1000),
          fullscreenDialog: true,
          child: MyBorrowRequestScreen(),
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
      path: '/borrow_request_list',
      name: AppRouteName.borrowRequestListRouteName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: const Duration(milliseconds: 1000),
          fullscreenDialog: true,
          child: BorrowRequestsListScreen(),
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
