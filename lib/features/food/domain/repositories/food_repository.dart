import 'package:dartz/dartz.dart';
import '../entities/food.dart';
import '../../../../core/error/failures.dart';

abstract class FoodRepository {
  Future<Either<Failure, List<Food>>> getFoodList();
  Future<Either<Failure, List<Food>>> getFavoriteFoods();
  Future<Either<Failure, void>> addFavoriteFood(Food food);
  Future<Either<Failure, void>> removeFavoriteFood(String id);
}
