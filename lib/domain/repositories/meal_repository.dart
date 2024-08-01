import 'package:dartz/dartz.dart';
import 'package:food_app/core/error/failures.dart';
import 'package:food_app/domain/entities/meal.dart';

abstract class MealRepository {
  Future<Either<Failure, List<Meal>>> getMeals();
  Future<Either<Failure, void>> addFavorite(Meal meal);
  Future<Either<Failure, void>> removeFavorite(String id);
  Future<Either<Failure, List<Meal>>> getFavorites();
}
