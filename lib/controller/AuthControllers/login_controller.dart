import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../constants/text_constants.dart';

class LogInController {
  final firebaseAuthInstants = FirebaseAuth.instance;

  Future logUserIn(String email, String password) async {
    try {
      await firebaseAuthInstants
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((_) => Get.toNamed(RoutesConstants.MAINPAGE))
          .then((_) => Get.snackbar("Success", "Login Is Successfully"));
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
