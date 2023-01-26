// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_muscle/view/screens/food/food.dart';
import 'package:quantum_muscle/view/screens/messages/messages.dart';
import 'package:quantum_muscle/view/screens/settings/settings.dart';
import 'package:quantum_muscle/view/screens/workouts/workouts.dart';

class MainPageController extends GetxController {
  static List<Widget> children = <Widget>[
     FoodPage(),
     WorkoutsPage(),
     MessagesPage(),
     SettingsPage()
  ];

  var navIconColor = Get.theme.iconTheme.color.obs;
  void onColorChange(){
    navIconColor = Get.theme.iconTheme.color.obs;
  }

  var selectedIndex = 0.obs;
  void onTabTapped(int index) {
    selectedIndex.value = index;
  }
}
// 
