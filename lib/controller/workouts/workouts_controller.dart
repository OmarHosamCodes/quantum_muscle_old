import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quantum_muscle/model/workouts/exercise_model.dart';

class WorkoutsController {
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;

  Future createWorkout(String workoutName) async {
    User? user = firebaseAuth.currentUser;
    ExerciseModel exerciseModel = ExerciseModel();

    if (user != null) {
      exerciseModel.exerciseName = 'Exercise Name';
      exerciseModel.exerciseTarget = 'Exercise Target';
      exerciseModel.sets = [
        "12 x 40",
        "12 x 60",
        "12 x 80",
        "12 x 100",
      ];

      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .collection('workouts')
          .doc(workoutName)
          .set(exerciseModel.toMap());
    } else {
      print("Error");
    }
  }
}
