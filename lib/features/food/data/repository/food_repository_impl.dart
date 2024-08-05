import 'package:dartz/dartz.dart';
import 'package:food_app/features/food/data/datasource/food_local_data_source.dart';
import 'package:food_app/features/food/data/datasource/food_remote_data_source.dart';
import 'package:food_app/features/food/data/models/food_model.dart';
import '../../domain/entities/food.dart';
import '../../domain/repositories/food_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class FoodRepositoryImpl implements FoodRepository {
  final FoodRemoteDataSource remoteDataSource;
  final FoodLocalDataSource localDataSource;

  FoodRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Food>>> getFoodList() async {
    try {
      final remoteFoods = await remoteDataSource.getFoodList();
      return Right(remoteFoods);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Food>>> getFavoriteFoods() async {
    try {
      final localFoods = await localDataSource.getFavoriteFoods();
      return Right(localFoods);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addFavoriteFood(Food food) async {
    try {
      final foodModel = FoodModel(
        idMeal: food.idMeal,
        strMeal: food.strMeal,
        strCategory: food.strCategory,
        strArea: food.strArea,
        strInstructions: food.strInstructions,
        strMealThumb: food.strMealThumb,
        strTags: food.strTags ?? '',
        strYoutube: food.strYoutube ?? '',
      );
      await localDataSource.addFavoriteFood(foodModel);
      print("SUCCESS addFavoriteFood");
      return Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeFavoriteFood(String id) async {
    try {
      await localDataSource.removeFavoriteFood(id);
      return Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
