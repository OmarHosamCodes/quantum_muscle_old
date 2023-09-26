import '../../library.dart';

class ThemeController {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: const Color.fromRGBO(236, 242, 248, 1),
    focusColor: Get.theme.scaffoldBackgroundColor,
    primaryColor: const Color.fromRGBO(98, 0, 238, .6),
    iconTheme: const IconThemeData(color: Colors.black),
    cardTheme: const CardTheme(
      color: Color.fromRGBO(98, 0, 238, .6),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        color: const Color.fromRGBO(158, 158, 158, 1),
        fontSize: 40.sp,
        fontFamily: 'family',
        fontWeight: FontWeight.normal,
      ),
      titleMedium: const TextStyle(
        color: Color.fromRGBO(255, 255, 255, 1),
        fontWeight: FontWeight.bold,
        fontFamily: 'family',
        fontSize: 16,
      ),
      headlineLarge: TextStyle(
        fontSize: 70.sp,
        color: const Color.fromRGBO(0, 0, 0, 1),
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
        color: const Color.fromRGBO(0, 0, 0, 1),
        fontFamily: 'family',
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontSize: 40.sp,
        color: const Color.fromRGBO(66, 66, 66, 1),
        fontFamily: 'family',
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        fontSize: 25.sp,
        color: const Color.fromRGBO(0, 0, 0, 1),
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
      iconColor: const Color.fromRGBO(224, 224, 224, 1),
      focusColor: Get.theme.scaffoldBackgroundColor,
      hoverColor: Get.theme.scaffoldBackgroundColor,
      prefixIconColor: const Color.fromRGBO(224, 224, 224, 1),
      suffixIconColor: const Color.fromRGBO(224, 224, 224, 1),
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
    scaffoldBackgroundColor: Colors.grey[900],
    focusColor: Get.theme.scaffoldBackgroundColor,
    primaryColor: const Color.fromRGBO(98, 0, 238, .6),
    iconTheme: const IconThemeData(color: Colors.white),
    cardTheme: const CardTheme(
      color: Color.fromRGBO(98, 0, 238, .6),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
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
      iconColor: const Color.fromRGBO(224, 224, 224, 1),
      focusColor: Get.theme.scaffoldBackgroundColor,
      hoverColor: Get.theme.scaffoldBackgroundColor,
      prefixIconColor: const Color.fromRGBO(224, 224, 224, 1),
      suffixIconColor: const Color.fromRGBO(224, 224, 224, 1),
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
}
