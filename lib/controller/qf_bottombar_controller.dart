import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QFBottomBarController extends GetxController {
  Rx<Color> selectedColor = Get.theme.primaryColor.obs;
  Rx<Color> unSelectedColor = Colors.black.obs;

  inctrement() {
    unSelectedColor = selectedColor;
  }

  dectrement() {
    selectedColor = unSelectedColor;
  }
}
