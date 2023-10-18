import 'library.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final controller = Get.put(IntentController());

  controller.intentHandler();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void doOnce() {
    final _ = GetStorage();
    _.writeIfNull("mealsView", 0);
    _.writeIfNull("workoutsView", 0);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      builder: (_, child) {
        return GetMaterialApp(
          onInit: () {
            FlutterNativeSplash.remove();
            doOnce();
          },
          initialRoute: RoutesConstants.MASTERPAGE,
          darkTheme: darkTheme,
          themeMode: ThemeMode.dark,
          getPages: appRoutes,
        );
      },
    );
  }
}
