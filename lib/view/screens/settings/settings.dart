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
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GetBuilder<SettingsController>(
                init: SettingsController(),
                autoRemove: false,
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                    ),
                    child: AnimatedContainer(
                      duration: GetNumUtils(300).milliseconds,
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
                          Switch(
                            activeColor: Get.theme.scaffoldBackgroundColor,
                            value: controller.isThemeChanged,
                            onChanged: (val) {
                              controller.change(val).then(
                                    (value) => controller.changeTheme(),
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: 30,
              ),
              child: GestureDetector(
                onTap: () => firebaseAuth.signOut(),
                child: AnimatedContainer(
                  duration: GetNumUtils(300).milliseconds,
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
                      const Icon(
                        EvaIcons.logOutOutline,
                        color: Color.fromRGBO(224, 224, 224, 1),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
