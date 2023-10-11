// ignore_for_file: unused_local_variable

import 'dart:async';

import '../../library.dart';

class ForgetPasswordController extends GetxController {
  final firebaseAuthInstants = FirebaseAuth.instance;
  bool isEmailSent = false;
  int countDown = 30;

  resetPassword({required String email}) {
    try {
      firebaseAuthInstants.sendPasswordResetEmail(email: email);
      Get.rawSnackbar(
        title: PublicConstants.SUCCESS,
        message: PublicConstants.SENT,
      );
      isEmailSent = true;
      startTimer();
    } on FirebaseAuthException catch (e) {
      Get.rawSnackbar(
        title: PublicConstants.ERROR,
        message: e.message,
      );
    }
    update();
  }

  startTimer() {
    Timer timer = Timer.periodic(1.seconds, (internalTimer) {
      if (countDown == 0) {
        internalTimer.cancel();
        isEmailSent = false;
        update();
      } else {
        countDown--;
        update();
      }
    });
  }
}
