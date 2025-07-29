
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:library_resource_management/routes/app_route_names.dart';

class AuthController extends ChangeNotifier {
  final _loginFormKey = GlobalKey<FormState>();
  bool _obscure = true;
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  Map<String, dynamic> _body = {};
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  GlobalKey<FormState> get loginFormKey => _loginFormKey;
  TextEditingController get userEmailController => _userEmailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get otpController => _otpController;
  bool get obscure => _obscure;

  String userName = '';
  String userEmail = '';
  String userId = '';
  String userPhotoUrl = '';
  int? userHashCode;

  void setUserDetails(context, {required String name, required String email, required String id, String photoUrl = '',required int userHash}) {
    userName = name;
    userEmail = email;
    userId = id;
    userPhotoUrl = photoUrl ?? '';
    userHashCode = userHash;
    // GoRouter.of(context).pushNamed(AppRouteName.userDashboardRouteName);
    notifyListeners();
  }

  void toggleObscure() {
    _obscure = !_obscure;
    notifyListeners();
  }

  void clearForm() {
    _userEmailController.clear();
    _passwordController.clear();
    _body.clear();
    _obscure = true;
    notifyListeners();
  }

   Future<UserCredential?> googleLogin() async {
    try {
      final user = await GoogleSignIn().signIn();
      final googleAuth = await user?.authentication;

      final credential = GoogleAuthProvider.credential(idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

      print('*******************************************************');
      print(credential.idToken);
      print(credential.accessToken);
      print(credential.appleFullPersonName);
      print(credential.signInMethod);
      print(credential.secret);
      print(credential.token);
      print(credential.providerId);
      print(credential.asMap());
      print(credential.toString());
      print('*******************************************************');

      return await _auth.signInWithCredential(credential);

      // GoRouter.of(context).pushNamed(AppRouteName.userDashboardRouteName);
      // return FirebaseAuth.instance.currentUser != null;
    } catch (err) {
      print("Google sign-in failed: $err");
      // return false;
    }
    return null;
  }

  Future<void> handleLogout(context) async {
    try {
      await _googleSignIn.signOut();
      GoRouter.of(context).pushReplacementNamed(AppRouteName.loginRouteName);
      print('User signed out and disconnected from Google.');
    } catch (error) {
      print('Logout error: $error');
    }
  }
}
