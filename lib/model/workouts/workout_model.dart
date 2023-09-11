import '../../library.dart';

class WorkoutModel {
  String? workoutName;
  bool? isPinned;
  Timestamp? timeNow;

  WorkoutModel({this.workoutName, this.timeNow, this.isPinned});

  factory WorkoutModel.fromMap(map) {
    return WorkoutModel(
      workoutName: map['workoutName'],
      timeNow: map['timeNow'],
      isPinned: map['isPinned'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'workoutName': workoutName,
      'timeNow': timeNow,
      'isPinned': isPinned,
    };
  }
}
