import 'library.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await GetStorage.init();
  runApp(const MyApp());
}

//flutter clean ; flutter pub get ; clear
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
