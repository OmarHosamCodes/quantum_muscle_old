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

      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child(user.uid)
          .child("FoodImages")
          .child("${user.uid.substring(1, 6)}$mealGroupName$mealName");
      UploadTask uploadeTask = storageReference.putFile(imageFile);
      try {
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
      } catch (e) {
        Get.rawSnackbar(
          title: PublicConstants.ERROR,
          message: e.toString(),
        );
      }
    }
  }
}
