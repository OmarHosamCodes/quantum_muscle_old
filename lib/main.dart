import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quantum_muscle/constants/routes_constants.dart';
import 'package:quantum_muscle/controller/theme_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quantum_muscle/model/app_routes_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  

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
          initialRoute: RoutesConstants.loginPage,
          debugShowCheckedModeBanner: false,
          theme: ThemeController.lightTheme,
          getPages: appRoutes,
        );
      },
    );
  }
}
