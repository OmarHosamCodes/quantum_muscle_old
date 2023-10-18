class MealModel {
  String? mealName;
  String? mealIngredients;
  String? mealImage;

  MealModel({
    this.mealName,
    this.mealIngredients,
    this.mealImage,
  });

  factory MealModel.fromMap(map) {
    return MealModel(
      mealName: map['mealName'],
      mealIngredients: map['mealIngredients'],
      mealImage: map['mealImage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mealName': mealName,
      'mealIngredients': mealIngredients,
      'mealImage': mealImage,
    };
  }
}
