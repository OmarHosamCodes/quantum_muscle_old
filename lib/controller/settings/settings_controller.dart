import 'package:get/get.dart';

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
}
