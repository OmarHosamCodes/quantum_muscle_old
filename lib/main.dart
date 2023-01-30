import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quantum_muscle/controller/theme_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'constants/text_constants.dart';
import 'firebase_options.dart';
import 'model/app_routes_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      builder: (_, child) {
        return GetMaterialApp(
          initialRoute: RoutesConstants.MAINPAGE,
          debugShowCheckedModeBanner: false,
          showPerformanceOverlay: false,
          debugShowMaterialGrid: false,
          theme: ThemeController.lightTheme,
          darkTheme: ThemeController.darkTheme,
          themeMode: ThemeController().getThemeMode(),
          getPages: appRoutes,
        );
      },
    );
  }
}
