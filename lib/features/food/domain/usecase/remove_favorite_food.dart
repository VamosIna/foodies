import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:food_app/core/usecase/usecase.dart';
import 'package:food_app/features/food/data/repository/food_repository_impl.dart';
import 'package:food_app/features/food/domain/repositories/food_repository.dart';
import '../../../../core/error/failures.dart';

class RemoveFavoriteFood implements UseCase<void, Params> {
  final FoodRepository repository;

  RemoveFavoriteFood(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.removeFavoriteFood(params.id);
  }
}

class Params extends Equatable {
  final String id;

  Params({required this.id});

  @override
  List<Object?> get props => [id];
}
