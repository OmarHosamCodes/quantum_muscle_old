import 'dart:io';

import '../../library.dart';

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
