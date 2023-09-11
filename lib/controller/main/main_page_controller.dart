import '../../library.dart';

class MainPageController extends GetxController {
  static List<Widget> children = <Widget>[
    const MealGroupsPage(),
    const WorkoutsPage(),
    const SettingsPage()
  ];

  var selectedIndex = 1;
  void onTabTapped(int index) {
    selectedIndex = index;
    update();
  }
}
