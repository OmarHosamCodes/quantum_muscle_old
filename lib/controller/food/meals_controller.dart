import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:quantum_muscle/model/food/meal_model.dart';

class MealsController extends GetxController {
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;

  Future createMeal(String mealGroupName, String index, String mealName,
      String mealIngredients, File imageFile) async {
    User? user = firebaseAuth.currentUser;
    MealModel mealModel = MealModel();

    if (user != null) {
      mealModel.mealName = mealName;
      mealModel.mealIngredients = mealIngredients;
      mealModel.isEated = false;
      mealModel.timeNow = Timestamp.now();

      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child(user.uid)
          .child("FoodImages")
          .child("$mealGroupName$mealName${mealModel.timeNow}");
      UploadTask uploadTask = storageReference.putFile(imageFile);

      await uploadTask
          .then((_) async =>
              mealModel.mealImage = await storageReference.getDownloadURL())
          .whenComplete(() async => await firebaseFirestore
              .collection('users')
              .doc(user.uid)
              .collection('food')
              .doc(mealGroupName)
              .collection(index)
              .doc(mealModel.mealName)
              .set(mealModel.toMap()));
    }
  }

  Future deleteMealGroup(
      String mealGroupName, String index, String mealName) async {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .collection('food')
          .doc(mealGroupName)
          .collection(index)
          .doc(mealGroupName)
          .delete();
    }
  }

  Future pinMealGroupToTrue(
      String mealGroupName, String index, String mealName) async {
    User? user = firebaseAuth.currentUser;

    if (user != null) {
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .collection('food')
          .doc(mealGroupName)
          .collection(index)
          .doc(mealGroupName)
          .set(
        {
          "isEated": true,
        },
        SetOptions(
          merge: true,
        ),
      );
    }
  }

  Future pinMealGroupTofalse(
      String mealGroupName, String index, String mealName) async {
    User? user = firebaseAuth.currentUser;

    if (user != null) {
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .collection('food')
          .doc(mealGroupName)
          .collection(index)
          .doc(mealGroupName)
          .set(
        {
          "isEated": false,
        },
        SetOptions(
          merge: true,
        ),
      );
    }
  }

  bool isClicked = false;

  void showIngredients() {
    isClicked = true;
    update();
  }

  void hideIngredients() {
    isClicked = false;
    update();
  }
}
