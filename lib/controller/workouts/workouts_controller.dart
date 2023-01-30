import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WorkoutsController {
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;

  Future createWorkout(String workoutName, int index) async {
    User? user = firebaseAuth.currentUser;

    if (user != null) {
      final Map<String, String> field = {"Name": workoutName};

      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .collection('workouts')
          .doc(workoutName)
          .set(field);
    }
  }
}
