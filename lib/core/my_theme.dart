import 'package:flutter/material.dart';

class MyTheme {
  static const Color primaryColor = Color(0xFF003366);
  static const Color hintColor = Color(0xFFB0BEC5);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: const Color.fromARGB(255, 242, 243, 245),
      hintColor: const Color.fromARGB(255, 112, 130, 139),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.grey,
      appBarTheme: AppBarTheme(
        color: const Color.fromARGB(255, 22, 41, 60),
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Colors.black54,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      cardTheme: CardTheme(
        color: Colors.grey,
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        tileColor: Colors.grey[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: const Color.fromARGB(255, 30, 30, 30),
      hintColor: const Color.fromARGB(255, 160, 160, 160),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: const Color.fromARGB(255, 18, 18, 18),
      appBarTheme: AppBarTheme(
        color: const Color.fromARGB(255, 22, 41, 60),
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Colors.white70,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      cardTheme: CardTheme(
        color: Colors.grey[850],
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        tileColor: Colors.grey[800],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
