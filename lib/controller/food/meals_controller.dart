import '../../library.dart';

class MealsController extends GetxController {
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final getStorage = GetStorage();
  late int viewIndex = getStorage.read(storageKey);
  final storageKey = ('mealsView');

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
