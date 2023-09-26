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

      await firebaseFirestore
          .collection('users')
          .doc(user!.uid)
          .collection('food')
          .doc(mealGroupName)
          .set(mealGroupModel.toMap());
      Get.back();
    }
  }

  Future deleteMealGroup(String mealGroupName) async {
    if (user != null) {
      await firebaseFirestore
          .collection("users")
          .doc(user!.uid)
          .collection('food')
          .doc(mealGroupName)
          .delete();
      expandContainer();
    }
  }

  Future pinMealGroupToTrue(String mealGroupName) async {
    if (user != null) {
      await firebaseFirestore
          .collection("users")
          .doc(user!.uid)
          .collection('food')
          .doc(mealGroupName)
          .update({
        "isPinned": true,
      });
      expandContainer();
    }
  }

  Future pinMealGroupTofalse(String mealGroupName) async {
    if (user != null) {
      await firebaseFirestore
          .collection("users")
          .doc(user!.uid)
          .collection('food')
          .doc(mealGroupName)
          .update({
        "isPinned": false,
      });
      expandContainer();
    }
  }

  expandContainer() {
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
