import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:library_resource_management/routes/app_route_names.dart';
import 'package:provider/provider.dart';

import '../../../themes/custom_colors.dart';
import '../../../widgets/appbar/custom_appbar.dart';
import '../../../widgets/buttons/custom_elevated_button.dart';
import '../../../widgets/text_form_field/custom_text_form_field.dart';
import '../../../widgets/texts/custom_text.dart';
import 'controller/auth_controller.dart';
// import 'package:timezone/browser.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKeyAdmin = GlobalKey<FormState>();

  late GoogleSignInAccount userObj;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: ((didpop) {
        if (didpop) {
          return;
        }
        SystemNavigator.pop();
        exit(0);
      }),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            FocusScope.of(context).unfocus();
          }
        },
        child: Scaffold(
          appBar: _appBar(),
          body: _body(),
          backgroundColor: CustomColors.primaryWhite,
        ),
      ),
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: CustomAppBar(
        tabName: "Library Resource Management",
        applyShadow: true,
        size: 24,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: adminLogin(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget adminLogin() {
    return Consumer<AuthController>(
      builder: (context, _authProvider, _) {
        return
          Column(
            children: [
              // CustomText(text: 'Login Screen', isHeading: true),
              // const SizedBox(height: 24),
              // CustomTextFromField(
              //   controller: _authProvider.userEmailController,
              //   keyboardType: TextInputType.emailAddress,
              //   autoFocus: true,
              //   validator: (value) {
              //     String pattern =
              //         r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
              //     RegExp regex = RegExp(pattern);
              //     if (value == null || value.isEmpty) {
              //       return 'Email is required';
              //     } else if (!regex.hasMatch(value)) {
              //       return 'Enter a valid email address';
              //     }
              //     return null;
              //   },
              //   onChange: (value) {},
              //   hintText: 'jane@example.com',
              //   prefixIcon: Icon(Icons.email, color: Colors.grey.shade600),
              //   applySuffixIcon: false,
              // ),
              // const SizedBox(height: 16),
              // CustomTextFromField(
              //   controller: _authProvider.passwordController,
              //   obscure: _authProvider.obscure,
              //   validator:
              //       (value) => value!.isEmpty ? 'Password required' : null,
              //   onChange: (value) {},
              //   hintText: '••••••',
              //   prefixIcon: Icon(Icons.lock, color: Colors.grey.shade600),
              //   applySuffixIcon: true,
              //   suffixIcon: InkWell(
              //     onTap: () => _authProvider.toggleObscure(),
              //     child: Icon(
              //       _authProvider.obscure
              //           ? Icons.visibility_off
              //           : Icons.visibility,
              //       color: Colors.grey.shade600,
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 16),
              // CustomElevatedButton(
              //   onPressed: () {
              //     if (_formKeyAdmin.currentState?.validate() ?? false) {
              //       // _authProvider.login(context);
              //       print('Email: ${_authProvider.userEmailController.text}');
              //     } else {
              //       // NotiService().showNotification(
              //       //   id: 1,
              //       //   title: 'Fields required',
              //       //   body: 'Please enter email and password.',
              //       // );
              //     }
              //   },
              //   // width: 1,
              //   height: 50,
              //   borderRadius: 100,
              //   backgroundColor: CustomColors.primaryColor,
              //   widget: CustomText(text: 'Login', isSubHeading: true),
              // ),
              // const SizedBox(height: 16),
              // CustomText(text: 'New User? Click here', isContent: true),
              // const SizedBox(height: 16),
              CustomElevatedButton(
                backgroundColor: CustomColors.primaryColor,
                onPressed: () async {
                  // await _authProvider.googleLogin();
                  await GoogleSignIn().signIn().then((value){
                    setState(() {
                      userObj = value!;
                      print(userObj.email);
                      print(userObj.id);
                      print(userObj.displayName);
                      print(userObj.photoUrl);
                      print(userObj.authentication.toString());
                      print(userObj.authHeaders.toString());
                      print(userObj.hashCode);
                      print(userObj.runtimeType);
                      _authProvider.setUserDetails(context, name: userObj.displayName!, email: userObj.email, id: userObj.id, photoUrl: userObj.photoUrl!, userHash: userObj.hashCode);
                      GoRouter.of(context).pushNamed(AppRouteName.userDashboardRouteName);
                    });
                  });
                },
                height: 50,
                borderRadius: 100,
                widget: Row(
                  children: [
                    Image.asset('assets/icons/google.png', scale: 18,),
                    const SizedBox(width: 12,),
                    CustomText(
                      text: 'Sign in with google',
                      isSubHeading: true,
                    ),
                  ],
                ),
              ),
            ],
          );
      },
    );
  }
}
