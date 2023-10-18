class ExerciseModel {
  String? exerciseName;
  String? exerciseTarget;
  String? exerciseImage;
  Map<String, dynamic>? sets;

  ExerciseModel({
    this.exerciseName,
    this.exerciseTarget,
    this.exerciseImage,
    this.sets,
  });

  factory ExerciseModel.fromMap(map) {
    return ExerciseModel(
      exerciseName: map['exerciseName'],
      exerciseTarget: map['exerciseTarget'],
      exerciseImage: map['exerciseImage'],
      sets: map['sets'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'exerciseName': exerciseName,
      'exerciseTarget': exerciseTarget,
      'exerciseImage': exerciseImage,
      'sets': sets,
    };
  }
}
