import 'package:sqflite/sqflite.dart';
import '../models/food_model.dart';

abstract class FoodLocalDataSource {
  Future<List<FoodModel>> getFavoriteFoods();
  Future<void> addFavoriteFood(FoodModel food);
  Future<void> removeFavoriteFood(String id);
}

class FoodLocalDataSourceImpl implements FoodLocalDataSource {
  final Database database;

  FoodLocalDataSourceImpl({required this.database});

  @override
  Future<List<FoodModel>> getFavoriteFoods() async {
    final List<Map<String, dynamic>> maps = await database.query('favorites');

    return List.generate(maps.length, (i) {
      return FoodModel.fromJson(maps[i]);
    });
  }

  @override
  Future<void> addFavoriteFood(FoodModel food) async {
    await database.insert(
      'favorites',
      food.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("SUCCESS addFavoriteFood");

  }

  @override
  Future<void> removeFavoriteFood(String id) async {
    await database.delete(
      'favorites',
      where: 'idMeal = ?',
      whereArgs: [id],
    );
  }
}
