import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quantum_muscle/model/workouts/workout_model.dart';

class WorkoutsController {
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;

  Future createWorkout(String workoutName) async {
    User? user = firebaseAuth.currentUser;
    WorkoutModel workoutModel = WorkoutModel();

    if (user != null) {
      workoutModel.workoutName = workoutName;
      workoutModel.timeNow = Timestamp.now();
      workoutModel.isPinned = false;

      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .collection('workouts')
          .doc(workoutName)
          .set(workoutModel.toMap());
    }
  }

  Future deleteWorkout(String workoutName) async {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .collection('workouts')
          .doc(workoutName)
          .delete();
    }
  }

  Future pinWorkoutToTrue(String workoutName) async {
    User? user = firebaseAuth.currentUser;

    if (user != null) {
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .collection('workouts')
          .doc(workoutName)
          .update({
        "isPinned": true,
      });
    }
  }

  Future pinWorkoutTofalse(String workoutName) async {
    User? user = firebaseAuth.currentUser;

    if (user != null) {
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .collection('workouts')
          .doc(workoutName)
          .update({
        "isPinned": false,
      });
    }
  }
}
