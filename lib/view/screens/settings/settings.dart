import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_muscle/controller/theme_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children:  [
          ListTile(
            title:  Text("DarkMode", style: Get.textTheme.bodyMedium,),
            onTap: () => ThemeController().changeTheme(),
          ),
          const Spacer(),
          ListTile(
            title: Text(
              "Logout",
              style: Get.textTheme.bodyMedium,
            ),
            onTap: () => FirebaseAuth.instance.signOut(),
          ),

        ],
      )),
    );
  }
}
