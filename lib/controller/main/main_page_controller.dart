import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_muscle/view/screens/food/meal_groups.dart';
import 'package:quantum_muscle/view/screens/settings/settings.dart';
import 'package:quantum_muscle/view/screens/workouts/workouts.dart';

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
