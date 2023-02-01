import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quantum_muscle/view/screens/main/main_page.dart';

class ThemeController {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.grey[300],
    focusColor: Get.theme.scaffoldBackgroundColor,
    primaryColor: Colors.teal,
    iconTheme: const IconThemeData(color: Colors.black),
    cardTheme: const CardTheme(
      color: Colors.teal,
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        color: Colors.grey[500],
        fontSize: 40.sp,
        fontFamily: 'family',
        fontWeight: FontWeight.normal,
      ),
      titleMedium: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: 'family',
        fontSize: 16,
      ),
      headlineLarge: TextStyle(
        fontSize: 70.sp,
        color: Colors.black,
        fontFamily: 'family',
        fontWeight: FontWeight.normal,
      ),
      headlineMedium: TextStyle(
        fontSize: 50.sp,
        color: Get.theme.scaffoldBackgroundColor,
        fontFamily: 'family',
        fontWeight: FontWeight.normal,
      ),
      headlineSmall: TextStyle(
        fontSize: 25.sp,
        color: Get.theme.scaffoldBackgroundColor,
        fontFamily: 'family',
        fontWeight: FontWeight.normal,
      ),
      bodyLarge: TextStyle(
        fontSize: 100.sp,
        color: Colors.black,
        fontFamily: 'family',
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontSize: 40.sp,
        color: Colors.grey.shade800,
        fontFamily: 'family',
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        fontSize: 25.sp,
        color: Colors.black,
        fontFamily: 'family',
        fontWeight: FontWeight.normal,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: Get.textTheme.headlineMedium,
      hintStyle: Get.textTheme.headlineMedium,
      errorStyle: Get.textTheme.headlineMedium,
      helperStyle: Get.textTheme.headlineMedium,
      prefixStyle: Get.textTheme.headlineMedium,
      suffixStyle: Get.textTheme.headlineMedium,
      counterStyle: Get.textTheme.headlineMedium,
      floatingLabelStyle: Get.textTheme.headlineMedium,
      fillColor: Get.theme.scaffoldBackgroundColor,
      iconColor: Get.theme.scaffoldBackgroundColor,
      focusColor: Get.theme.scaffoldBackgroundColor,
      hoverColor: Get.theme.scaffoldBackgroundColor,
      prefixIconColor: Get.theme.scaffoldBackgroundColor,
      suffixIconColor: Get.theme.scaffoldBackgroundColor,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Get.theme.focusColor, width: 2),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Get.theme.focusColor,
        ),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Get.theme.colorScheme.error,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStatePropertyAll(Get.theme.scaffoldBackgroundColor),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: Colors.green.shade200)
        .copyWith(error: Colors.red.shade700),
  );
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.grey[900],
    focusColor: Get.theme.scaffoldBackgroundColor,
    primaryColor: Colors.teal,
    iconTheme: const IconThemeData(color: Colors.white),
    cardTheme: const CardTheme(
      color: Colors.teal,
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        color: Colors.grey[500],
        fontSize: 40.sp,
        fontFamily: 'family',
        fontWeight: FontWeight.normal,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
        fontFamily: 'family',
      ),
      headlineLarge: TextStyle(
        fontSize: 70.sp,
        color: Colors.white70,
        fontFamily: 'family',
        fontWeight: FontWeight.normal,
      ),
      headlineMedium: TextStyle(
        fontSize: 50.sp,
        color: Get.theme.scaffoldBackgroundColor,
        fontFamily: 'family',
        fontWeight: FontWeight.normal,
      ),
      headlineSmall: TextStyle(
        fontSize: 25.sp,
        color: Get.theme.scaffoldBackgroundColor,
        fontFamily: 'family',
        fontWeight: FontWeight.normal,
      ),
      bodyLarge: TextStyle(
        fontSize: 100.sp,
        color: Colors.white70,
        fontFamily: 'family',
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontSize: 40.sp,
        color: Colors.white70,
        fontFamily: 'family',
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        fontSize: 25.sp,
        color: Colors.white70,
        fontFamily: 'family',
        fontWeight: FontWeight.normal,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: Get.textTheme.headlineMedium,
      hintStyle: Get.textTheme.headlineMedium,
      errorStyle: Get.textTheme.headlineMedium,
      helperStyle: Get.textTheme.headlineMedium,
      prefixStyle: Get.textTheme.headlineMedium,
      suffixStyle: Get.textTheme.headlineMedium,
      counterStyle: Get.textTheme.headlineMedium,
      floatingLabelStyle: Get.textTheme.headlineMedium,
      fillColor: Get.theme.scaffoldBackgroundColor,
      iconColor: Get.theme.scaffoldBackgroundColor,
      focusColor: Get.theme.scaffoldBackgroundColor,
      hoverColor: Get.theme.scaffoldBackgroundColor,
      prefixIconColor: Get.theme.scaffoldBackgroundColor,
      suffixIconColor: Get.theme.scaffoldBackgroundColor,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Get.theme.focusColor, width: 2),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Get.theme.focusColor,
        ),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Get.theme.colorScheme.error,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStatePropertyAll(Get.theme.scaffoldBackgroundColor),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: Colors.green.shade200)
        .copyWith(error: Colors.red.shade700),
  );

  final getStorage = GetStorage();

  final darkThemeKey = ('isDarkTheme');

  Future saveThemeData(bool isDarkMode) async {
    getStorage.write(darkThemeKey, isDarkMode);
  }

  bool isSavedDarkMode() {
    return getStorage.read(darkThemeKey) ?? false;
  }

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  Future changeTheme() async {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    await saveThemeData(!isSavedDarkMode());
    await pageController.animateToPage(0,
        duration: 100.milliseconds, curve: Curves.ease);
    await pageController.animateToPage(2,
        duration: 100.milliseconds, curve: Curves.ease);
  }
}
