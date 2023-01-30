import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/text_constants.dart';
import '../../model/auth/user_model.dart';

class SignupController extends GetxController {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  Future signUserUp(
    String email,
    String password,
    String userName,
    GlobalKey<FormState> formKey,
  ) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((_) => afterSignUp(userName))
          .then((_) => Get.toNamed(RoutesConstants.MAINPAGE))
          .then((_) => Get.snackbar("Success", "Register Is Successfully"));
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message!);
    }
  }

  afterSignUp(String userName) async {
    User? user = firebaseAuth.currentUser;

    UserModel userModel = UserModel();

    if (user != null) {
      userModel.email = user.email;
      userModel.uid = user.uid;
      userModel.userName = userName;
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(userModel.toMap());
    }
  }
}
