import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeController extends GetxController {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.grey[300],
    appBarTheme: AppBarTheme(color: Colors.grey.shade500, centerTitle: true),
    focusColor: Get.theme.scaffoldBackgroundColor,
    errorColor: Colors.red.shade700,
    primaryColor: Colors.teal,
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: Colors.green.shade200),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 16,
      ),
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
}
