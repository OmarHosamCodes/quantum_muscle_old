import '../../../library.dart';

final PageController pageController = PageController(initialPage: 1);

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = FirebaseAuth.instance;
    final globalKey = GlobalKey();
    // final controller = Get.put(IntentController());
    return StreamBuilder<User?>(
      key: globalKey,
      stream: firebaseAuth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GetBuilder<MainPageController>(
            init: MainPageController(),
            autoRemove: false,
            builder: (controller) => Scaffold(
              resizeToAvoidBottomInset: false,
              extendBodyBehindAppBar: true,
              extendBody: false,
              bottomNavigationBar: GNav(
                onTabChange: (index) {
                  controller.onTabTapped(index);
                  pageController.animateToPage(
                    index,
                    duration: 300.milliseconds,
                    curve: Curves.linear,
                  );
                },
                selectedIndex: controller.selectedIndex,
                curve: Curves.linear,
                duration: 300.milliseconds,
                gap: 10,
                iconSize: 25,
                tabs: [
                  GButton(
                    iconActiveColor: Get.theme.primaryColor,
                    iconColor: Get.theme.primaryColor,
                    text: ClearRoutesConstants.MEALSPAGE,
                    icon: FontAwesomeIcons.bowlFood,
                  ),
                  GButton(
                    iconActiveColor: Get.theme.primaryColor,
                    iconColor: Get.theme.primaryColor,
                    text: ClearRoutesConstants.WORKOUTSPAGE,
                    icon: FontAwesomeIcons.dumbbell,
                  ),
                  GButton(
                    iconActiveColor: Get.theme.primaryColor,
                    iconColor: Get.theme.primaryColor,
                    text: ClearRoutesConstants.SETTINGSPAGE,
                    icon: FontAwesomeIcons.gear,
                  ),
                ],
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
