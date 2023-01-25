import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final firebaseAuthInstants = FirebaseAuth.instance;
  bool isEmailSent = false;

  increment({required String email}) {
    try {
      firebaseAuthInstants.sendPasswordResetEmail(email: email);
      Get.snackbar("Success", "Sent");
      isEmailSent = true;
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

    update();
  }

  decrement() {
    isEmailSent = false;
    update();
  }
}
