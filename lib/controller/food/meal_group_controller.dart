import '../../library.dart';

class MealGroupController extends GetxController {
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  double containerHeight = 200.h;
  bool isContainerExpanded = false;
  late User? user = firebaseAuth.currentUser;

  Future createMealGroup(String mealGroupName) async {
    MealGroupModel mealGroupModel = MealGroupModel();

    if (user != null) {
      mealGroupModel.mealGroupName = mealGroupName;
      mealGroupModel.isPinned = false;
      try {
        Get.back();
        await firebaseFirestore
            .collection('users')
            .doc(user!.uid)
            .collection('food')
            .doc(mealGroupName)
            .set(mealGroupModel.toMap());
      } catch (e) {
        Get.rawSnackbar(
          title: PublicConstants.ERROR,
          message: e.toString(),
        );
      }
    }
  }

  Future deleteMealGroup(String mealGroupName) async {
    if (user != null) {
      try {
        changeContainerSize();
        await firebaseFirestore
            .collection("users")
            .doc(user!.uid)
            .collection('food')
            .doc(mealGroupName)
            .delete();
      } catch (e) {
        Get.rawSnackbar(
          title: PublicConstants.ERROR,
          message: e.toString(),
        );
      }
    }
  }

  Future pinMealGroupToTrue(String mealGroupName) async {
    if (user != null) {
      try {
        changeContainerSize();
        await firebaseFirestore
            .collection("users")
            .doc(user!.uid)
            .collection('food')
            .doc(mealGroupName)
            .update({
          "isPinned": true,
        });
      } catch (e) {
        Get.rawSnackbar(
          title: PublicConstants.ERROR,
          message: e.toString(),
        );
      }
    }
  }

  Future pinMealGroupTofalse(String mealGroupName) async {
    if (user != null) {
      changeContainerSize();

      await firebaseFirestore
          .collection("users")
          .doc(user!.uid)
          .collection('food')
          .doc(mealGroupName)
          .update({
        "isPinned": false,
      });
    }
  }

  changeContainerSize() {
    isContainerExpanded ? containerHeight = 200.h : containerHeight = 500.h;

    if (isContainerExpanded) {
      isContainerExpanded = !isContainerExpanded;
      update();
    } else {
      Future.delayed(300.milliseconds).then(
        (value) {
          isContainerExpanded = !isContainerExpanded;
          update();
        },
      );
    }
    update();
  }
}
