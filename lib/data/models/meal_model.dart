import 'package:food_app/domain/entities/meal.dart';

class MealModel extends Meal {
  MealModel({
    required String id,
    required String name,
    required String category,
    required String instructions,
    required String imageUrl,
  }) : super(
    id: id,
    name: name,
    category: category,
    instructions: instructions,
    imageUrl: imageUrl,
  );

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['idMeal'],
      name: json['strMeal'],
      category: json['strCategory'],
      instructions: json['strInstructions'],
      imageUrl: json['strMealThumb'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMeal': id,
      'strMeal': name,
      'strCategory': category,
      'strInstructions': instructions,
      'strMealThumb': imageUrl,
    };
  }
}
