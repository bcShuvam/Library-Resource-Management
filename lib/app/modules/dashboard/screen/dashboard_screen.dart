import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_resource_management/app/modules/login/controller/auth_controller.dart';
import 'package:library_resource_management/widgets/texts/custom_text.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/appbar/custom_appbar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: CustomAppBar(
        tabName: "Dashboard",
        applyShadow: true,
        size: 24,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _body() {
    return Consumer<AuthController>(
      builder: (context, authController, _) {
        return Center(
          child: Column(
            children: [
              CustomText(text: authController.userId,isContent: true,),
              CustomText(text: authController.userEmail,isContent: true,),
              CustomText(text: authController.userName,isContent: true,),
              CircleAvatar(
                radius: 60,
                  // : BorderRadius.circular(100),
                  child: authController.userPhotoUrl.isNotEmpty ? Image.network(authController.userPhotoUrl.toString()) : Icon(FontAwesomeIcons.person,size: 50,)),
              CustomText(text: authController.userHashCode.toString(),isContent: true,),
            ],
          ),
        );
      }
    );
  }
}
