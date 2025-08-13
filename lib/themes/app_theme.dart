import 'package:flutter/material.dart';

class AppTheme {
  static const Color myPrimaryColor = Color(0xFF4A90E2);

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: myPrimaryColor,
    scaffoldBackgroundColor: Colors.grey.shade50,

    // Define a color scheme seeded by primary color, customize surfaces and backgrounds
    colorScheme: ColorScheme.fromSeed(
      seedColor: myPrimaryColor,
      brightness: Brightness.light,
      background: Colors.grey.shade100, // general background
      surface: Colors.white,             // cards, sheets, surfaces
      onSurface: Colors.black87,         // text on surfaces
      onPrimary: Colors.white,           // text on primary
      primary: myPrimaryColor,
      secondary: Colors.deepPurple,      // you can tweak if needed
    ),

    // Card background color override
    cardColor: Colors.white,

    textTheme: Typography.blackCupertino,

    iconTheme: const IconThemeData(color: Colors.black),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: myPrimaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF4A90E2),
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: myPrimaryColor,
      foregroundColor: Colors.white,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: myPrimaryColor,
    scaffoldBackgroundColor: const Color(0xFF262626),

    // Dark color scheme seeded by primary color
    colorScheme: ColorScheme.fromSeed(
      seedColor: myPrimaryColor,
      brightness: Brightness.dark,
      background: const Color(0xFF262626), // general background
      surface: const Color(0xFF333333),    // card & surface color
      onSurface: Colors.white70,            // text on surfaces
      onPrimary: Colors.black,              // text on primary color
      primary: myPrimaryColor,
      secondary: Colors.deepPurpleAccent,  // tweak if needed
    ),

    // Card background color override for dark mode
    cardColor: const Color(0xFF333333),

    textTheme: Typography.whiteCupertino,

    iconTheme: const IconThemeData(color: Colors.white),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: myPrimaryColor,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: myPrimaryColor,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: myPrimaryColor,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
  );
}
