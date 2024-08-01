import 'package:dio/dio.dart';
import 'package:food_app/core/error/exceptions.dart';
import 'package:food_app/data/models/meal_model.dart';

abstract class MealRemoteDataSource {
  Future<List<MealModel>> getMeals();
}

class MealRemoteDataSourceImpl implements MealRemoteDataSource {
  final Dio client;

  MealRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MealModel>> getMeals() async {
    final response = await client.get('https://www.themealdb.com/api/json/v1/1/search.php?s=');
    if (response.statusCode == 200) {
      return (response.data['meals'] as List).map((meal) => MealModel.fromJson(meal)).toList();
    } else {
      throw ServerException();
    }
  }
}
