import 'library.dart';

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

//flutter clean ; flutter pub get ; clear ; flutter build apk --release
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    doOnce();
  }

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
          initialRoute: RoutesConstants.MASTERPAGE,
          debugShowCheckedModeBanner: false,
          showPerformanceOverlay: false,
          debugShowMaterialGrid: false,
          enableLog: false,
          theme: ThemeController.lightTheme,
          darkTheme: ThemeController.darkTheme,
          themeMode: SettingsController().getThemeMode(),
          getPages: appRoutes,
        );
      },
    );
  }
}
