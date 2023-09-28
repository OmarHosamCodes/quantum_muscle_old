import '../../library.dart';

class MainPageController extends GetxController {
  static const List<Widget> children = <Widget>[
    MealGroupsPage(),
    WorkoutsPage(),
    SettingsPage()
  ];

  int selectedIndex = 1;
  void onTabTapped(int index) {
    selectedIndex = index;
    update();
  }

  void resetIndex() {
    selectedIndex = 1;
    update();
  }
}
