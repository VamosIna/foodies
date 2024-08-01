import 'package:food_app/data/models/meal_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class MealLocalDataSource {
  Future<void> insertFavorite(MealModel meal);
  Future<void> removeFavorite(String id);
  Future<List<MealModel>> getFavorites();
}

class MealLocalDataSourceImpl implements MealLocalDataSource {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'meals.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites(
            id TEXT PRIMARY KEY,
            name TEXT,
            category TEXT,
            instructions TEXT,
            imageUrl TEXT
          )
        ''');
      },
    );
  }

  @override
  Future<void> insertFavorite(MealModel meal) async {
    final db = await database;
    await db.insert(
      'favorites',
      meal.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removeFavorite(String id) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<MealModel>> getFavorites() async {
    final db = await database;
    final maps = await db.query('favorites');

    if (maps.isEmpty) return [];
    return List.generate(maps.length, (i) {
      return MealModel.fromJson(maps[i]);
    });
  }
}
