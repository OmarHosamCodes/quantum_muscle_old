import '../../../library.dart';

final PageController pageController = PageController(initialPage: 1);

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = FirebaseAuth.instance;
    return StreamBuilder<User?>(
      stream: firebaseAuth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GetBuilder(
            init: MainPageController(),
            builder: (controller) => Scaffold(
              resizeToAvoidBottomInset: false,
              extendBodyBehindAppBar: true,
              extendBody: false,
              bottomNavigationBar: SafeArea(
                child: GNav(
                  onTabChange: (index) {
                    controller.onTabTapped(index);
                    pageController.animateToPage(index,
                        duration: 300.milliseconds,
                        curve: Curves.linearToEaseOut);
                  },
                  selectedIndex: controller.selectedIndex,
                  curve: Curves.linear,
                  duration: 300.milliseconds,
                  gap: 8,
                  activeColor: Get.theme.primaryColor,
                  iconSize: 30,
                  padding:
                      EdgeInsets.only(left: 70.w, right: 70.w, bottom: 100.h),
                  tabs: const [
                    GButton(
                      // iconColor: Get.theme.iconTheme.color,
                      icon: EvaIcons.archiveOutline,
                    ),
                    GButton(
                      // iconColor: Get.theme.iconTheme.color,
                      icon: EvaIcons.menu,
                    ),
                    GButton(
                      // iconColor: Get.theme.iconTheme.color,
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
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: QFProgressIndicator());
        }
        return const LoginPage();
      },
    );
  }
}
