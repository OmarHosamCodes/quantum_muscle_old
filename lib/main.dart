import 'library.dart';

final _intentController = Get.put(IntentController());
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  _intentController.intentHandler();
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
          onInit: () => FlutterNativeSplash.remove(),
          onDispose: () => _intentController.dataStreamSubscription!.cancel(),
          initialRoute: RoutesConstants.MASTERPAGE,
          darkTheme: darkTheme,
          themeMode: ThemeMode.dark,
          getPages: appRoutes,
        );
      },
    );
  }
}
