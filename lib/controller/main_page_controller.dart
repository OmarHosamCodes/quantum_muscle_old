import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/screens/testpage.dart';

class MainPageController extends GetxController {
  static List<Widget> children = <Widget>[
    const TestPage(
      index: 0,
    ),
    const TestPage(
      index: 1,
    ),
    const TestPage(
      index: 2,
    ),
    const TestPage(
      index: 3,
    )
  ];

  var selectedIndex = 0.obs;
  void onTabTapped(int index) {
    selectedIndex.value = index;
  }
}
