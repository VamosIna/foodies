import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:food_app/core/usecase/usecase.dart';
import 'package:food_app/features/food/data/repository/food_repository_impl.dart';
import 'package:food_app/features/food/domain/repositories/food_repository.dart';
import '../../../../core/error/failures.dart';
import '../entities/food.dart';

class GetFoodList implements UseCase<List<Food>, NoParams> {
  final FoodRepository repository;

  GetFoodList(this.repository);

  @override
  Future<Either<Failure, List<Food>>> call(NoParams params) async {
    return await repository.getFoodList();
  }
}
