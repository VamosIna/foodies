import 'package:food_app/features/food/data/datasource/food_local_data_source.dart';
import 'package:food_app/features/food/data/datasource/food_remote_data_source.dart';
import 'package:food_app/features/food/data/repository/food_repository_impl.dart';
import 'package:food_app/features/food/domain/repositories/food_repository.dart';
import 'package:food_app/features/food/domain/usecase/add_favorite_food.dart';
import 'package:food_app/features/food/domain/usecase/remove_favorite_food.dart';
import 'package:food_app/features/food/presentation/bloc/food_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../features/food/domain/usecase/get_favorite_foods.dart';
import '../../features/food/domain/usecase/get_food_list.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // External
  final database = await openDatabase(
    join(await getDatabasesPath(), 'food_database.db'),
    onCreate: (db, version) {
      return db.execute(
        '''
        CREATE TABLE favorites (
          idMeal TEXT PRIMARY KEY,
          strMeal TEXT,
          strCategory TEXT,
          strArea TEXT,
          strInstructions TEXT,
          strMealThumb TEXT,
          strTags TEXT,
          strYoutube TEXT
        )
        ''',
      );
    },
    version: 2, // Increment the version
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        await db.execute(
            '''
          ALTER TABLE favorites ADD COLUMN idMeal TEXT PRIMARY KEY
          '''
        );
      }
    },
  );

  sl.registerLazySingleton(() => database);
  sl.registerLazySingleton(() => Dio(BaseOptions(
    baseUrl: 'https://www.themealdb.com/api/json/v1/1/',
    headers: {
      'Content-Type': 'application/json',
      // Include your API key here if required
      // 'Authorization': 'Bearer YOUR_API_KEY',
    },
  )));

  // Data sources
  sl.registerLazySingleton<FoodRemoteDataSource>(() => FoodRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<FoodLocalDataSource>(() => FoodLocalDataSourceImpl(database: sl()));

  // Repository
  sl.registerLazySingleton<FoodRepository>(() => FoodRepositoryImpl(
    remoteDataSource: sl(),
    localDataSource: sl(),
  ));

  // Use cases
  sl.registerLazySingleton(() => GetFoodList(sl()));
  sl.registerLazySingleton(() => GetFavoriteFoods(sl()));
  sl.registerLazySingleton(() => AddFavoriteFood(sl()));
  sl.registerLazySingleton(() => RemoveFavoriteFood(sl()));

  // Bloc
  sl.registerFactory(() => FoodBloc(
    getFoodList: sl(),
    getFavoriteFoods: sl(),
    addFavoriteFood: sl(),
    removeFavoriteFood: sl(),
  ));
}