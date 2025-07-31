import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:library_resource_management/routes/app_route.dart';
import 'package:library_resource_management/themes/app_theme.dart';
import 'package:library_resource_management/themes/theme_change_controller.dart';
import 'package:provider/provider.dart';
import 'app/modules/bottom_navigation/controller/bottom_navigation_controller.dart';
import 'app/modules/login/controller/auth_controller.dart';
import 'firebase_msg.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseMsg().initFCM();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _notifier,
      builder: (_, mode, __) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => ThemeChangeController(),
            ),
            ChangeNotifierProvider(create: (context) => AuthController()),
            ChangeNotifierProvider(
              create: (context) => BottomNavigationProvider(),
            ),
          ],
          child: Builder(
            builder: (BuildContext context) {
              final themeChangeController = Provider.of<ThemeChangeController>(context);
              return MaterialApp.router(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                // themeMode: themeChangeController.themeMode,
                themeMode: ThemeMode.system,
                theme: AppTheme.lightTheme,     // ✅ use custom theme
                darkTheme: AppTheme.darkTheme, // ✅ use custom theme
                routerConfig: appRouter,
              );
            },
          ),
        );
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      },
    );
  }
}
