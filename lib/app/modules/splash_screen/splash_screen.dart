import 'package:flutter/material.dart';
import 'package:library_resource_management/app/modules/splash_screen/controller/splash_controller.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashController splashController;

  @override
  void initState() {
    super.initState();
    // Future.microtask(() {
      final splashController = Provider.of<SplashController>(context, listen: false);
      splashController.isTokenValid(context: context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
