import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../constants/routes_constants.dart';

class LogInController {
  // final TextEditingController emailAddressController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  final firebaseAuthInstants = FirebaseAuth.instance;

  Future logUserIn(String email, String password) async {
    try {
      await firebaseAuthInstants
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .whenComplete(() => Get.toNamed(RoutesConstants.mainPage))
          .whenComplete(() => Get.snackbar("Success", "Login Is Successfully"));
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
