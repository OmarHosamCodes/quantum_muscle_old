import 'dart:io';

import '../../library.dart';

class CreateExerciseController {
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;

  Future<void> createExercise(String workoutName, String index,
      String exerciseName, String exerciseTarget, File imageFile) async {
    User? user = firebaseAuth.currentUser;
    ExerciseModel exerciseModel = ExerciseModel();

    if (user != null) {
      exerciseModel.exerciseName = exerciseName;
      exerciseModel.exerciseTarget = 'Target: $exerciseTarget';
      exerciseModel.sets = {
        "0": "",
        "1": "",
        "2": "",
        "3": "",
      };
      exerciseModel.isDone = false;
      exerciseModel.timeNow = Timestamp.now();
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child(user.uid)
          .child("ExercisesImages")
          .child(
              "$workoutName$exerciseName$exerciseTarget${exerciseModel.timeNow}");
      UploadTask uploadeTask = storageReference.putFile(imageFile);
      try {
        await uploadeTask
            .then((_) async => exerciseModel.exerciseImage =
                await storageReference.getDownloadURL())
            .whenComplete(
              () async => await firebaseFirestore
                  .collection('users')
                  .doc(user.uid)
                  .collection('workouts')
                  .doc(workoutName)
                  .collection(index)
                  .doc(exerciseModel.exerciseName)
                  .set(exerciseModel.toMap()),
            );
      } catch (e) {
        Get.rawSnackbar(
          title: PublicConstants.ERROR,
          message: e.toString(),
        );
      }
    }
  }
}
