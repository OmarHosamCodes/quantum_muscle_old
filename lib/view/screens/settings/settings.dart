import '../../../library.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      autoRemove: true,
      builder: (controller) {
        return Scaffold(
          extendBody: true,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: GestureDetector(
                    onTap: () =>
                        controller.change(!controller.isThemeChanged).then(
                              (value) => controller.changeTheme(),
                            ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      width: double.infinity,
                      height: 200.h,
                      decoration: BoxDecoration(
                        color: Get.theme.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          controller.isSavedDarkMode()
                              ? Text(
                                  SettingsConstants.DARKTHEME,
                                  style: Get.textTheme.headlineMedium,
                                )
                              : Text(
                                  SettingsConstants.LIGHTTHEME,
                                  style: Get.textTheme.headlineMedium,
                                ),
                          controller.isThemeChanged
                              ? Icon(EvaIcons.sun,
                                  color: Get
                                      .theme.iconButtonTheme.style!.iconColor!
                                      .resolve({}))
                              : Icon(EvaIcons.moon,
                                  color: Get
                                      .theme.iconButtonTheme.style!.iconColor!
                                      .resolve({})),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 30,
                  ),
                  child: GestureDetector(
                    onTap: () => firebaseAuth.signOut(),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      width: double.infinity,
                      height: 200.h,
                      decoration: BoxDecoration(
                        color: Get.theme.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            SettingsConstants.LOGOUT,
                            style: Get.textTheme.headlineMedium,
                          ),
                          Icon(
                            EvaIcons.logOutOutline,
                            color: Get.theme.iconButtonTheme.style!.iconColor!
                                .resolve({}),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
