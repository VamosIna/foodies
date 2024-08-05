import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/food.dart';

part 'food_model.g.dart';

@JsonSerializable()
class FoodModel extends Food {
  FoodModel({
    required String idMeal,
    required String strMeal,
    required String strCategory,
    required String strArea,
    required String strInstructions,
    required String strMealThumb,
    String? strTags,
    String? strYoutube,
  }) : super(
    idMeal: idMeal,
    strMeal: strMeal,
    strCategory: strCategory,
    strArea: strArea,
    strInstructions: strInstructions,
    strMealThumb: strMealThumb,
    strTags: strTags ?? '',
    strYoutube: strYoutube ?? '',
  );

  factory FoodModel.fromJson(Map<String, dynamic> json) => _$FoodModelFromJson(json);
  Map<String, dynamic> toJson() => _$FoodModelToJson(this);
}
