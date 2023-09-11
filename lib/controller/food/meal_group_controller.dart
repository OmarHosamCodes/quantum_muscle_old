import '../../library.dart';

class MealGroupController {
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;

  Future createMealGroup(String mealGroupName) async {
    User? user = firebaseAuth.currentUser;
    MealGroupModel mealGroupModel = MealGroupModel();

    if (user != null) {
      mealGroupModel.mealGroupName = mealGroupName;
      mealGroupModel.isPinned = false;

      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .collection('food')
          .doc(mealGroupName)
          .set(mealGroupModel.toMap());
    }
  }

  Future deleteMealGroup(String mealGroupName) async {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .collection('food')
          .doc(mealGroupName)
          .delete();
    }
  }

  Future pinMealGroupToTrue(String mealGroupName) async {
    User? user = firebaseAuth.currentUser;

    if (user != null) {
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .collection('food')
          .doc(mealGroupName)
          .update({
        "isPinned": true,
      });
    }
  }

  Future pinMealGroupTofalse(String mealGroupName) async {
    User? user = firebaseAuth.currentUser;

    if (user != null) {
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .collection('food')
          .doc(mealGroupName)
          .update({
        "isPinned": false,
      });
    }
  }
}
