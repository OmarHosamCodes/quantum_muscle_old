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
      Get.rawSnackbar(
        title: PublicConstants.ERROR,
        message: e.message,
      );
    }
  }
}
