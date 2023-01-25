import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_muscle/constants/routes_constants.dart';
import '../../model/auth/user_model.dart';

class SignupController extends GetxController {
  final firebaseAuthInstants = FirebaseAuth.instance;
  final firebaseFirestoreInstants = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;

  void signUserUp(
      String email, String password, String userName, String errorMessage) {
    try {
      firebaseAuthInstants
          .createUserWithEmailAndPassword(email: email, password: password)
          .whenComplete(() => afterSignUp(userName))
          .whenComplete(
        () {
          Get.offNamedUntil(
            RoutesConstants.mainPage,
            (route) => false,
          );
          Get.snackbar("Success", "Register Is Successfully");
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
