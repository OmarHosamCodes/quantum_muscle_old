import '../../../library.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = FirebaseAuth.instance;

    return Scaffold(
      extendBody: true,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RowedText(
              child: Text(
            SettingsConstants.THEME,
            style: Get.textTheme.headlineLarge,
          )),
          SizedBox(
            height: 20.h,
          ),
          ListTile(
            title: ThemeController().isSavedDarkMode()
                ? Text(
                    SettingsConstants.DARKTHEME,
                    style: Get.textTheme.headlineMedium,
                  )
                : Text(
                    SettingsConstants.LIGHTTHEME,
                    style: Get.textTheme.headlineMedium,
                  ),
            onTap: () => ThemeController().changeTheme(),
            tileColor: Get.theme.primaryColor,
          ),
          SizedBox(
            height: 50.h,
          ),
          RowedText(
              child: Text(
            SettingsConstants.ACCOUNT,
            style: Get.textTheme.headlineLarge,
          )),
          SizedBox(
            height: 20.h,
          ),
          ListTile(
            title: Text(
              SettingsConstants.LOGOUT,
              style: Get.textTheme.headlineMedium,
            ),
            onTap: () => firebaseAuth.signOut(),
            tileColor: Get.theme.primaryColor,
          ),
        ],
      )),
    );
  }
}
