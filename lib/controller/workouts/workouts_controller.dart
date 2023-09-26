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

      await firebaseFirestore
          .collection('users')
          .doc(user!.uid)
          .collection('workouts')
          .doc(workoutName)
          .set(workoutModel.toMap());
      Get.back();
    }
  }

  Future deleteWorkout(String workoutName) async {
    if (user != null) {
      await firebaseFirestore
          .collection("users")
          .doc(user!.uid)
          .collection('workouts')
          .doc(workoutName)
          .delete();
    }
  }

  Future pinWorkoutToTrue(String workoutName) async {
    if (user != null) {
      await firebaseFirestore
          .collection("users")
          .doc(user!.uid)
          .collection('workouts')
          .doc(workoutName)
          .update({
        "isPinned": true,
      });
      expandContainer();
    }
  }

  Future pinWorkoutTofalse(String workoutName) async {
    if (user != null) {
      await firebaseFirestore
          .collection("users")
          .doc(user!.uid)
          .collection('workouts')
          .doc(workoutName)
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
