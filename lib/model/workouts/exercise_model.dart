import 'package:cloud_firestore/cloud_firestore.dart';

class ExerciseModel {
  String? exerciseName;
  String? exerciseTarget;
  String? exerciseImage;
  Map<String, String>? sets;
  bool? isDone;
  Timestamp? timeNow;

  ExerciseModel(
      {this.exerciseName,
      this.exerciseTarget,
      this.exerciseImage,
      this.sets,
      this.isDone,
      this.timeNow});

  factory ExerciseModel.fromMap(map) {
    return ExerciseModel(
      exerciseName: map['exerciseName'],
      exerciseTarget: map['exerciseTarget'],
      exerciseImage: map['exerciseImage'],
      sets: map['sets'],
      isDone: map['isDone'],
      timeNow: map['timeNow'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'exerciseName': exerciseName,
      'exerciseTarget': exerciseTarget,
      'exerciseImage': exerciseImage,
      'sets': sets,
      'isDone': isDone,
      "timeNow": timeNow
    };
  }
}
