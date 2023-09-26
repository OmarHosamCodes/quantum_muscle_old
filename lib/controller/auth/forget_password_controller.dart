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
      decrement();
    } on FirebaseAuthException catch (e) {
      String? errorMessage;
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          errorMessage = 'Invalid email address';
          break;
        case 'ERROR_USER_NOT_FOUND':
          errorMessage = 'User not found';
          break;
        default:
          errorMessage = 'An error occurred, please try again later';
          break;
      }
      Get.rawSnackbar(
        title: PublicConstants.ERROR,
        message: errorMessage,
      );
    }

    update();
  }

  decrement() {
    // ignore: unused_local_variable
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
