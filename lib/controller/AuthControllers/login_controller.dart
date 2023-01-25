import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_muscle/constants/routes_constants.dart';

class LogInController extends GetxController {
  // final TextEditingController emailAddressController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  final firebaseAuthInstants = FirebaseAuth.instance;

  void logUserIn(String email, String password) {
    try {
      firebaseAuthInstants
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .whenComplete(
        () {
          Get.offNamedUntil(
            RoutesConstants.mainPage,
            (route) => false,
          );
          Get.snackbar("Success", "Login Is Successfully");
        },
      );
    } on FirebaseAuthException catch (e) {
      Get.dialog(Dialog(
        backgroundColor: Get.theme.primaryColor,
        elevation: 0,
        insetAnimationDuration: 300.milliseconds,
        child: Text(
          e.toString(),
          style: Get.textTheme.bodyMedium,
        ),
      ));
    }
  }
}
