import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:library_resource_management/app/modules/profile/controller/profile_controller.dart';
import 'package:library_resource_management/app/modules/profile/model/profile_response_model.dart';
import 'package:library_resource_management/core/end_points.dart';
import 'package:library_resource_management/core/http_service.dart';
import 'package:library_resource_management/routes/app_route_names.dart';

import '../../../utils/snackbar_utils.dart';

class SplashController extends ChangeNotifier {
  final ProfileController profileController;
  SplashController(this.profileController);

  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> isTokenValid({required BuildContext context}) async {
    final response = await HttpService.get(endpoint: EndPoints.test, context: context);
    debugPrint('Response datatype = ${response.runtimeType}');

    if (response.containsKey('error')) {
      debugPrint('Inside if block');
      if (context.mounted) {
        handleLogout(context);
        GoRouter.of(context).pushReplacementNamed(AppRouteName.loginRouteName);
      }
      return; // ✅ Prevent further execution
        // GoRouter.of(context).pushReplacementNamed(AppRouteName.loginRouteName);
    } else {
      await profileController.fetchProfile();
      if (context.mounted) {
        if (profileController.role == 'Admin') {
          GoRouter.of(context).pushReplacementNamed(AppRouteName.adminDashboardRouteName);
        } else if (profileController.role == 'Student') {
          // GoRouter.of(context).pushReplacementNamed(AppRouteName.adminDashboardRouteName);
          GoRouter.of(context).pushReplacementNamed(AppRouteName.studentDashboardRouteName);
        } else {
          GoRouter.of(context).pushReplacementNamed(AppRouteName.loginRouteName);
        }
      }
    }
    // if (context.mounted) {
      // notifyListeners();
    // }
  }

  Future<void> handleLogout(context) async {
    try {
      await _googleSignIn.signOut();
      // SnackBarUtils.showSuccessSnackbar(context, message: "Logged out successfully");
      GoRouter.of(context).pushReplacementNamed(AppRouteName.loginRouteName);
      debugPrint('User signed out and disconnected from Google.');
    } catch (error) {
      debugPrint('Logout error: $error');
    }
  }
}