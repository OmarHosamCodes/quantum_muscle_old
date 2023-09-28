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
                gap: 5,
                iconSize: 30,
                tabs: const [
                  GButton(
                    text: ClearRoutesConstants.MEALSPAGE,
                    icon: EvaIcons.archiveOutline,
                  ),
                  GButton(
                    text: ClearRoutesConstants.WORKOUTSPAGE,
                    icon: EvaIcons.menu,
                  ),
                  GButton(
                    text: ClearRoutesConstants.SETTINGSPAGE,
                    icon: EvaIcons.settings2Outline,
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
