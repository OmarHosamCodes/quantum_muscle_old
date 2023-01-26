import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_muscle/controller/main_page_controller.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quantum_muscle/view/screens/auth/error.dart';
import 'package:quantum_muscle/view/screens/auth/login.dart';

final PageController pageController = PageController();

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final controller = Get.put(MainPageController());
  final firebaseAuthInstants = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: firebaseAuthInstants.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Obx(
            () => Scaffold(
              resizeToAvoidBottomInset: false,
              extendBodyBehindAppBar: true,
              extendBody: false,
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
                  activeColor: Colors.teal,
                  iconSize: 30,
                  padding: EdgeInsets.only(
                      left: 70.0.w, right: 70.0.w, bottom: 100.0.h),
                  tabs: [
                    GButton(
                      iconColor: Get.theme.iconTheme.color,
                      icon: EvaIcons.homeOutline,
                    ),
                    GButton(
                      iconColor: Get.theme.iconTheme.color,
                      icon: EvaIcons.gridOutline,
                    ),
                    GButton(
                      iconColor: Get.theme.iconTheme.color,
                      icon: EvaIcons.messageSquareOutline,
                    ),
                    GButton(
                      iconColor: Get.theme.iconTheme.color,
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
        } else if (snapshot.hasError) {
          return const ErrorPage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
