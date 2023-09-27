import 'dart:io';

import '../../library.dart';

class MealsController extends GetxController {
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final getStorage = GetStorage();
  late int viewIndex = getStorage.read(storageKey);
  final storageKey = ('mealsView');

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
      try {
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
      } on FirebaseAuthException catch (e) {
        Get.rawSnackbar(
          title: PublicConstants.ERROR,
          message: e.toString(),
        );
      }
    }
  }

  Future deleteMealGroup(
      String mealGroupName, String index, String mealName) async {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      try {
        await firebaseFirestore
            .collection("users")
            .doc(user.uid)
            .collection('food')
            .doc(mealGroupName)
            .collection(index)
            .doc(mealGroupName)
            .delete();
      } on FirebaseAuthException catch (e) {
        Get.rawSnackbar(
          title: PublicConstants.ERROR,
          message: e.toString(),
        );
      }
    }
  }

  Future pinMealGroupToTrue(
      String mealGroupName, String index, String mealName) async {
    User? user = firebaseAuth.currentUser;

    if (user != null) {
      try {
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
      } catch (e) {
        Get.rawSnackbar(
          title: PublicConstants.ERROR,
          message: e.toString(),
        );
      }
    }
  }

  Future pinMealGroupTofalse(
      String mealGroupName, String index, String mealName) async {
    User? user = firebaseAuth.currentUser;

    if (user != null) {
      try {
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
      } catch (e) {
        Get.rawSnackbar(
          title: PublicConstants.ERROR,
          message: e.toString(),
        );
      }
    }
  }

  Future changeView() async {
    getStorage.write(storageKey, (viewIndex + 1) % 3);
    viewIndex = await getStorage.read(storageKey);
    update();
  }
}
