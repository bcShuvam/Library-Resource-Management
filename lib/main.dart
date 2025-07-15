import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:library_resource_management/routes/app_route.dart';
import 'package:provider/provider.dart';
import 'app/modules/login/controller/auth_controller.dart';
import 'firebase_msg.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

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
          ChangeNotifierProvider(create: (context) => AuthController()),
        ],
        child: MaterialApp.router(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          routerConfig: appRouter,
        ),
      // title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      );
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    });
  }
}
