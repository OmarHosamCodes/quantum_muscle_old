import '../../library.dart';

class WorkoutsController extends GetxController {
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  late User? user = firebaseAuth.currentUser;
  double containerHeight = 200.h;
  bool isContainerExpanded = false;
  Future createWorkout(String workoutName) async {
    WorkoutModel workoutModel = WorkoutModel();

    if (user != null) {
      workoutModel.workoutName = workoutName;
      workoutModel.timeNow = Timestamp.now();
      workoutModel.isPinned = false;
      try {
        Get.back();
        await firebaseFirestore
            .collection('users')
            .doc(user!.uid)
            .collection('workouts')
            .doc(workoutName)
            .set(workoutModel.toMap());
      } catch (e) {
        Get.rawSnackbar(
          title: PublicConstants.ERROR,
          message: e.toString(),
        );
      }
    }
  }

  Future deleteWorkout(String workoutName) async {
    if (user != null) {
      try {
        changeControllerSize();
        await firebaseFirestore
            .collection("users")
            .doc(user!.uid)
            .collection('workouts')
            .doc(workoutName)
            .delete();
      } catch (e) {
        Get.rawSnackbar(
          title: PublicConstants.ERROR,
          message: e.toString(),
        );
      }
    }
  }

  Future pinWorkoutToTrue(String workoutName) async {
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
      } catch (e) {
        Get.rawSnackbar(
          title: PublicConstants.ERROR,
          message: e.toString(),
        );
      }
    }
  }

  Future pinWorkoutTofalse(String workoutName) async {
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
      } catch (e) {
        Get.rawSnackbar(
          title: PublicConstants.ERROR,
          message: e.toString(),
        );
      }
    }
  }

  changeControllerSize() {
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
