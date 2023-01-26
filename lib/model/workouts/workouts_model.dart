import 'package:quantum_muscle/model/workouts/exercise_model.dart';

class WorkoutsModel {
  String? workoutName;
  List<ExerciseModel>? exercises;

  WorkoutsModel({
    this.workoutName,
    this.exercises,
  });

  // receiving data from server
  factory WorkoutsModel.fromMap(map) {
    return WorkoutsModel(
      workoutName: map['workoutName'],
      exercises: map['exercises'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'workoutName': workoutName,
      'exercises': exercises,
    };
  }
}
