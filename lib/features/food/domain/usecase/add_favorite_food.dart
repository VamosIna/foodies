import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:food_app/core/usecase/usecase.dart';
import 'package:food_app/features/food/data/repository/food_repository_impl.dart';
import 'package:food_app/features/food/domain/repositories/food_repository.dart';
import '../../../../core/error/failures.dart';
import '../entities/food.dart';

class AddFavoriteFood implements UseCase<void, Food> {
  final FoodRepository repository;

  AddFavoriteFood(this.repository);

  @override
  Future<Either<Failure, void>> call(Food food) async {
    return await repository.addFavoriteFood(food);
  }
}
