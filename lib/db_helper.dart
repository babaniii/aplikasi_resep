import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'model_resep.dart';

class DBHelper {
  static Future<Database> _database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'recipes.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE recipes(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, preparation_time TEXT, ingredients TEXT, instructions TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertRecipe(Recipe recipe) async {
    final db = await _database();
    await db.insert(
      'recipes',
      recipe.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateRecipe(Recipe recipe) async {
    final db = await _database();
    await db.update(
      'recipes',
      recipe.toMap(),
      where: 'id = ?',
      whereArgs: [recipe.id],
    );
  }

  static Future<void> deleteRecipe(int id) async {
    final db = await _database();
    await db.delete(
      'recipes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Recipe>> getRecipes() async {
    final db = await _database();
    final List<Map<String, dynamic>> maps = await db.query('recipes');
    return List.generate(maps.length, (i) {
      return Recipe(
        id: maps[i]['id'],
        name: maps[i]['name'],
        preparationTime: maps[i]['preparation_time'],
        ingredients: maps[i]['ingredients'],
        instructions: maps[i]['instructions'],
      );
    });
  }
}
