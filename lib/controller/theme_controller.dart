import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quantum_muscle/view/screens/main/main_page.dart';
import '../constants/text_constants.dart';

class ThemeController {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.grey[300],
    focusColor: Get.theme.scaffoldBackgroundColor,
    errorColor: Colors.red.shade700,
    primaryColor: Colors.teal,
    iconTheme: const IconThemeData(color: Colors.black),
    cardTheme: const CardTheme(
      color: Colors.teal,
    ),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: Colors.green.shade200),
    textTheme: TextTheme(
      titleSmall: TextStyle(color: Colors.grey[500], fontSize: 40.sp),
      titleMedium: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      headlineLarge: TextStyle(fontSize: 70.sp, color: Colors.black),
      headlineMedium:
          TextStyle(fontSize: 50.sp, color: Get.theme.scaffoldBackgroundColor),
      headlineSmall:
          TextStyle(fontSize: 25.sp, color: Get.theme.scaffoldBackgroundColor),
      // labelMedium: TextStyle(fontSize: 30.sp, color: ),
      bodyLarge: TextStyle(fontSize: 100.sp, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 40.sp, color: Colors.grey.shade800),
      bodySmall: TextStyle(fontSize: 25.sp, color: Colors.black),
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
          color: Get.theme.errorColor,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStatePropertyAll(Get.theme.scaffoldBackgroundColor),
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.grey[900],
    focusColor: Get.theme.scaffoldBackgroundColor,
    errorColor: Colors.red.shade700,
    primaryColor: Colors.teal,
    iconTheme: const IconThemeData(color: Colors.white),
    cardTheme: const CardTheme(
      color: Colors.teal,
    ),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: Colors.green.shade200),
    textTheme: TextTheme(
      titleSmall: TextStyle(color: Colors.grey[500], fontSize: 40.sp),
      titleMedium: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      headlineLarge: TextStyle(fontSize: 70.sp, color: Colors.white70),
      headlineMedium:
          TextStyle(fontSize: 50.sp, color: Get.theme.scaffoldBackgroundColor),
      headlineSmall:
          TextStyle(fontSize: 25.sp, color: Get.theme.scaffoldBackgroundColor),
      bodyLarge: TextStyle(fontSize: 100.sp, color: Colors.white70),
      bodyMedium: TextStyle(fontSize: 40.sp, color: Colors.white70),
      bodySmall: TextStyle(fontSize: 25.sp, color: Colors.white70),
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
          color: Get.theme.errorColor,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStatePropertyAll(Get.theme.scaffoldBackgroundColor),
      ),
    ),
  );

  final getStorage = GetStorage();

  final darkThemeKey = ('isDarkTheme');

  void saveThemeData(bool isDarkMode) {
    getStorage.write(darkThemeKey, isDarkMode);
  }

  bool isSavedDarkMode() {
    return getStorage.read(darkThemeKey) ?? false;
  }

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme() {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeData(!isSavedDarkMode());
    Get.offAndToNamed(
      RoutesConstants.MAINPAGE,
      result: (route) => false,
    );
    pageController.jumpToPage(1);
  }
}
