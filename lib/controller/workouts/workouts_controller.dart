import '../../library.dart';

class WorkoutsController extends GetxController {
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  late User? user = firebaseAuth.currentUser;
  double containerHeight = 200.h;
  bool isContainerExpanded = false;
  Future<void> createWorkout(String workoutName) async {
    WorkoutModel workoutModel = WorkoutModel();

    if (user != null) {
      try {
        workoutModel.workoutName = workoutName;
        workoutModel.isPinned = false;
        Get.back();
        update();
        await firebaseFirestore
            .collection('users')
            .doc(user!.uid)
            .collection('workouts')
            .doc(workoutName)
            .set(workoutModel.toMap());
        update();
        Get.reloadAll(force: true);
      } catch (e) {
        Get.rawSnackbar(
          title: PublicConstants.ERROR,
          message: e.toString(),
        );
      }
    }
  }

  Future<void> deleteWorkout(String workoutName) async {
    if (user != null) {
      try {
        changeControllerSize();
        await firebaseFirestore
            .collection("users")
            .doc(user!.uid)
            .collection('workouts')
            .doc(workoutName)
            .delete();
        Get.reloadAll(force: true);
      } catch (e) {
        Get.rawSnackbar(
          title: PublicConstants.ERROR,
          message: e.toString(),
        );
      }
    }
  }

  Future<void> pinWorkoutToTrue(String workoutName) async {
    if (user != null) {
      try {
        changeControllerSize();
        await firebaseFirestore
            .collection("users")
            .doc(user!.uid)
            .collection('workouts')
            .doc(workoutName)
            .update({
          "isPinned": true,
        });
        update();
      } catch (e) {
        Get.rawSnackbar(
          title: PublicConstants.ERROR,
          message: e.toString(),
        );
      }
    }
  }

  Future<void> pinWorkoutTofalse(String workoutName) async {
    if (user != null) {
      try {
        changeControllerSize();
        await firebaseFirestore
            .collection("users")
            .doc(user!.uid)
            .collection('workouts')
            .doc(workoutName)
            .update({
          "isPinned": false,
        });
        update();
      } catch (e) {
        Get.rawSnackbar(
          title: PublicConstants.ERROR,
          message: e.toString(),
        );
      }
    }
  }

  void changeControllerSize() {
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
