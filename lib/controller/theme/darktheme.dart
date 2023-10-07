import '../../library.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color.fromRGBO(21, 21, 21, 1),
  focusColor: const Color.fromRGBO(21, 21, 21, 1),
  primaryColor: const Color.fromRGBO(96, 125, 139, 1),
  primaryColorLight: const Color.fromRGBO(96, 125, 139, 1),
  primaryColorDark: const Color.fromRGBO(96, 125, 139, 1),
  iconTheme: const IconThemeData(color: Color.fromRGBO(224, 224, 224, 1)),
  cardTheme: const CardTheme(
    color: Color.fromRGBO(224, 224, 224, .9),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStatePropertyAll(
        Color.fromRGBO(224, 224, 224, .9),
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 50.sp,
      color: const Color.fromRGBO(236, 242, 248, 1),
      fontFamily: 'family',
      letterSpacing: 10,
      fontWeight: FontWeight.normal,
    ),
  ),
  textTheme: TextTheme(
    titleSmall: TextStyle(
      color: const Color.fromRGBO(255, 255, 255, 1),
      fontSize: 40.sp,
      fontFamily: 'family',
      fontWeight: FontWeight.normal,
    ),
    titleMedium: TextStyle(
      color: const Color.fromRGBO(255, 255, 255, 1),
      fontWeight: FontWeight.bold,
      fontSize: 50.sp,
      fontFamily: 'family',
    ),
    titleLarge: TextStyle(
      color: const Color.fromRGBO(255, 255, 255, 1),
      fontWeight: FontWeight.bold,
      fontSize: 70.sp,
      fontFamily: 'family',
    ),
    headlineLarge: TextStyle(
      fontSize: 70.sp,
      color: const Color.fromRGBO(255, 255, 255, .702),
      fontFamily: 'family',
      fontWeight: FontWeight.normal,
    ),
    headlineMedium: TextStyle(
      fontSize: 50.sp,
      color: const Color.fromRGBO(21, 21, 21, 1),
      fontFamily: 'family',
      fontWeight: FontWeight.normal,
    ),
    headlineSmall: TextStyle(
      fontSize: 25.sp,
      color: const Color.fromRGBO(21, 21, 21, 1),
      fontFamily: 'family',
      fontWeight: FontWeight.normal,
    ),
    bodyLarge: TextStyle(
      fontSize: 100.sp,
      color: const Color.fromRGBO(255, 255, 255, 0.702),
      fontFamily: 'family',
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      fontSize: 40.sp,
      color: const Color.fromRGBO(255, 255, 255, 0.702),
      fontFamily: 'family',
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      fontSize: 25.sp,
      color: const Color.fromRGBO(255, 255, 255, 0.702),
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
    fillColor: const Color.fromRGBO(21, 21, 21, 1),
    iconColor: const Color.fromRGBO(224, 224, 224, 1),
    focusColor: const Color.fromRGBO(21, 21, 21, 1),
    hoverColor: const Color.fromRGBO(21, 21, 21, 1),
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
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(
        Color.fromRGBO(21, 21, 21, 1),
      ),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: const Color.fromRGBO(165, 214, 167, 1))
      .copyWith(error: const Color.fromRGBO(211, 47, 47, 1)),
);
