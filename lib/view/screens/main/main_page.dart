import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_muscle/controller/main_page_controller.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final PageController pageController = PageController();
  final controller = Get.put(MainPageController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        extendBody: true,
        bottomNavigationBar: SafeArea(
          child: GNav(
            onTabChange: (index) {
              controller.onTabTapped(index);
              pageController.animateToPage(
                index,
                duration: 300.milliseconds,
                curve: Curves.ease,
              );
            },
            selectedIndex: controller.selectedIndex.value,
            curve: Curves.linear,
            duration: 900.milliseconds,
            gap: 8,
            color: Colors.black,
            activeColor: Colors.teal,
            iconSize: 30,
            padding:
                EdgeInsets.only(left: 70.0.w, right: 70.0.w, bottom: 100.0.h),
            tabs: const [
              GButton(
                icon: EvaIcons.homeOutline,
              ),
              GButton(
                icon: EvaIcons.gridOutline,
              ),
              GButton(
                icon: EvaIcons.messageSquareOutline,
              ),
              GButton(
                icon: EvaIcons.settings2Outline,
              ),
            ],
          ),
        ),
        body: PageView(
          onPageChanged: (index) => controller.onTabTapped(index),
          controller: pageController,
          children: MainPageController.children,
        ),
      ),
    );
  }
}
