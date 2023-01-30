// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_muscle/view/screens/food/food.dart';

import 'package:quantum_muscle/view/screens/settings/settings.dart';
import 'package:quantum_muscle/view/screens/workouts/workouts.dart';

class MainPageController extends GetxController {
  static List<Widget> children = <Widget>[
    FoodPage(),
    WorkoutsPage(),
    SettingsPage()
  ];

  var selectedIndex = 1.obs;
  void onTabTapped(int index) {
    selectedIndex.value = index;
  }
}
// 
