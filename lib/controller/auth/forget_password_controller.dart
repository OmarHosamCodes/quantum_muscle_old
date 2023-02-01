import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../constants/text_constants.dart';

class ForgetPasswordController extends GetxController {
  final firebaseAuthInstants = FirebaseAuth.instance;
  bool isEmailSent = false;

  resetPassword({required String email}) {
    try {
      firebaseAuthInstants.sendPasswordResetEmail(email: email);
      Get.rawSnackbar(
        title: PublicConstants.SUCCESS,
        message: PublicConstants.SENT,
      );
      isEmailSent = true;
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
    isEmailSent = false;
    update();
  }
}
