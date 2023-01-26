import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quantum_muscle/model/workouts/workouts_model.dart';

class WorkoutsController {
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;

  Future createWorkout(String workoutName) async {
    User? user = firebaseAuth.currentUser;
    WorkoutsModel workoutsModel = WorkoutsModel();

    if (user != null) {
      workoutsModel.workoutName = workoutName;
      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .collection('workouts')
          .doc(workoutName)
          .set(workoutsModel.toMap());
    } else {
      print("Error");
    }
  }
}
