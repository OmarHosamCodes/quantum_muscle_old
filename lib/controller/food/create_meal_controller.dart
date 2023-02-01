import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quantum_muscle/model/food/meal_model.dart';

class CreateMealController {
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;

  Future createMeal(String mealGroupName, String index, String mealName,
      String mealIngredients, File imageFile) async {
    User? user = firebaseAuth.currentUser;
    MealModel mealModel = MealModel();

    if (user != null) {
      mealModel.mealName = mealName;
      mealModel.mealIngredients = mealIngredients;
      // mealModel.mealImage= imageFile;
      mealModel.timeNow = Timestamp.now();
      mealModel.isEated = false;
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child(user.uid)
          .child("FoodImages")
          .child("$mealGroupName$mealName${mealModel.timeNow}");
      UploadTask uploadeTask = storageReference.putFile(imageFile);

      await uploadeTask
          .then((_) async =>
              mealModel.mealImage = await storageReference.getDownloadURL())
          .whenComplete(
            () async => await firebaseFirestore
                .collection('users')
                .doc(user.uid)
                .collection("food")
                .doc(mealGroupName)
                .collection(index)
                .doc(mealModel.mealName)
                .set(mealModel.toMap()),
          );
    }
  }
}
