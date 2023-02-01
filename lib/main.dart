import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quantum_muscle/controller/theme/theme_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quantum_muscle/view/screens/main/main_page.dart';
import 'package:quick_actions/quick_actions.dart';
import 'constants/text_constants.dart';
import 'firebase_options.dart';
import 'model/app_routes_model.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
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
          initialRoute: RoutesConstants.MASTERPAGE,
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

class MasterPage extends StatefulWidget {
  const MasterPage({super.key});

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  final QuickActions quickActions = const QuickActions();
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    quickActions.initialize((String shortcutType) async {
      switch (shortcutType) {
        case 'create_meal_group':
          return Get.to(() => const MainPage())!.then((_) {
            if (user != null) {
              pageController.jumpTo(0);
            } else {
              return;
            }
          });
        case 'create_workout':
          return Get.to(() => const MainPage())!.then((_) {
            if (user != null) {
              pageController.jumpTo(1);
            } else {
              return;
            }
          });
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'create_meal_group',
        localizedTitle: 'Create Meal',
      ),
      const ShortcutItem(
        type: 'create_workout',
        localizedTitle: 'Create Workout',
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return const MainPage();
  }
}
