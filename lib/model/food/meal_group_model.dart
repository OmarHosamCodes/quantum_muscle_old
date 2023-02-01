class MealGroupModel {
  String? mealGroupName;
  bool? isPinned;

  MealGroupModel({this.mealGroupName, this.isPinned});

  factory MealGroupModel.fromMap(map) {
    return MealGroupModel(
      mealGroupName: map['mealGroupName'],
      isPinned: map['isPinned'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mealGroupName': mealGroupName,
      'isPinned': isPinned,
    };
  }
}
