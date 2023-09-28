import 'package:flutter_animate/flutter_animate.dart';

import '../../library.dart';

class SettingsController extends GetxController {
  bool isThemeChanged = false;

  void onThemeChange() {
    if (isThemeChanged) {
      isThemeChanged = false;
      update();
    } else {
      isThemeChanged = true;
      update();
    }
  }

  Future change(bool val) async {
    isThemeChanged = val;
    update();
  }

  final getStorage = GetStorage();

  final darkThemeKey = ('isDarkTheme');

  Future saveThemeData(bool isDarkMode) async =>
      getStorage.write(darkThemeKey, isDarkMode);

  bool isSavedDarkMode() => getStorage.read(darkThemeKey) ?? false;

  ThemeMode getThemeMode() =>
      isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;

  changeTheme() async {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    await saveThemeData(!isSavedDarkMode());
    pageController
        .previousPage(duration: 300.ms, curve: Curves.ease)
        .whenComplete(
          () => pageController.nextPage(duration: 300.ms, curve: Curves.ease),
        );
    MainPageController().resetIndex();
    update();
  }
}
