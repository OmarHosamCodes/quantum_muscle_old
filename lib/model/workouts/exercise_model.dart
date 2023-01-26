class ExerciseModel {

  String exerciseName;
  String exerciseTarget;
  String? exerciseImage;
  List<String>? sets;

  ExerciseModel({
    required this.exerciseName,
    required this.exerciseTarget,
    this.exerciseImage,
    this.sets
  });
  
}