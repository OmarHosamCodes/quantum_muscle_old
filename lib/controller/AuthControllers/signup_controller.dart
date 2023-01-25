import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quantum_muscle/constants/routes_constants.dart';

import '../../model/auth/user_model.dart';

class SignupController extends GetxController {
  final FirebaseAuth firebaseAuthInstants = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestoreInstants = FirebaseFirestore.instance;

  void signUserUp(
      String email, String password, String userName, String errorMessage) {
    try {
      firebaseAuthInstants
          .createUserWithEmailAndPassword(email: email, password: password)
          .whenComplete(() => afterSignUp(userName))
          .whenComplete(() => Get.toNamed(RoutesConstants.homePage));
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }
  }

  afterSignUp(String userName) async {
    User? user = firebaseAuthInstants.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    if (user != null) {
      userModel.email = user.email;
      userModel.uid = user.uid;
      userModel.userName = userName;
      await firebaseFirestoreInstants
          .collection("users")
          .doc(user.uid)
          .set(userModel.toMap());
    } else {
      print("error");
    }
  }
}
