import 'package:cloud_firestore/cloud_firestore.dart';

class MealModel {
  String? mealName;
  String? mealIngredients;
  String? mealImage;
  bool? isEated;
  Timestamp? timeNow;

  MealModel({
    this.mealName,
    this.mealIngredients,
    this.mealImage,
    this.isEated,
    this.timeNow,
  });

  factory MealModel.fromMap(map) {
    return MealModel(
      mealName: map['mealName'],
      mealIngredients: map['mealIngredients'],
      mealImage: map['mealImage'],
      isEated: map['isEated'],
      timeNow: map['timeNow'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mealName': mealName,
      'mealIngredients': mealIngredients,
      'mealImage': mealImage,
      'isEated': isEated,
      'timeNow': timeNow,
    };
  }
}
