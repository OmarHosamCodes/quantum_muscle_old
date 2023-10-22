class WorkoutModel {
  String? workoutName;
  // bool? isPinned;

  WorkoutModel({
    this.workoutName,
    // this.isPinned,
  });

  factory WorkoutModel.fromMap(map) {
    return WorkoutModel(
      workoutName: map['workoutName'],
      // isPinned: map['isPinned'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'workoutName': workoutName,
      // 'isPinned': isPinned,
    };
  }
}
