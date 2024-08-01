import 'package:dartz/dartz.dart';
import 'package:food_app/core/error/exceptions.dart';
import 'package:food_app/core/error/failures.dart';
import 'package:food_app/data/datasource/meal_local_data_source.dart';
import 'package:food_app/data/datasource/meal_remote_data_source.dart';
import 'package:food_app/data/models/meal_model.dart';
import 'package:food_app/domain/entities/meal.dart';
import 'package:food_app/domain/repositories/meal_repository.dart';

class MealRepositoryImpl implements MealRepository {
  final MealRemoteDataSource remoteDataSource;
  final MealLocalDataSource localDataSource;

  MealRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Meal>>> getMeals() async {
    try {
      final remoteMeals = await remoteDataSource.getMeals();
      return Right(remoteMeals);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addFavorite(Meal meal) async {
    try {
      final mealModel = meal as MealModel;
      await localDataSource.insertFavorite(mealModel);
      return Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(String id) async {
    try {
      await localDataSource.removeFavorite(id);
      return Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Meal>>> getFavorites() async {
    try {
      final localFavorites = await localDataSource.getFavorites();
      return Right(localFavorites);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
