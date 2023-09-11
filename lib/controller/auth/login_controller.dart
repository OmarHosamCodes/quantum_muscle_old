import '../../library.dart';

class LogInController {
  final firebaseAuth = FirebaseAuth.instance;

  Future logUserIn(String email, String password) async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((_) {
        if (firebaseAuth.currentUser != null) {
          Get.snackbar(PublicConstants.SUCCESS, LoginConstants.LOGINSUCCESS);
        } else {
          return;
        }
      });
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
  }
}
