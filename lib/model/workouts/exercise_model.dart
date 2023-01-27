class ExerciseModel {
  String? exerciseName;
  String? exerciseTarget;
  String? exerciseImage;
  List<String>? sets;

  ExerciseModel(
      {this.exerciseName, this.exerciseTarget, this.exerciseImage, this.sets});
  // receiving data from server
  factory ExerciseModel.fromMap(map) {
    return ExerciseModel(
      exerciseName: map['exerciseName'],
      exerciseTarget: map['exerciseTarget'],
      exerciseImage: map['exerciseImage'],
      sets: map['sets'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'exerciseName': exerciseName,
      'exerciseTarget': exerciseTarget,
      'exerciseImage': exerciseImage,
      'sets': sets,
    };
  }
}
