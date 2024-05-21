import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipes/models/recipe_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _database;
  static DbHelper dbHelper = DbHelper._();
  final String tableName = 'recipes';
  final String nameColumn = 'name';
  final String idColumn = 'id';
  final String isFavoriteColumn = 'isFavorite';
  final String ingredientsColumn = 'ingredients';
  final String instructionsColumn = 'instructions';
  final String preperationTimeColumn = 'preperationTime';
  final String imageColumn = 'image';

  static final DbHelper db = DbHelper._();

  DbHelper._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initBD();
    return _database;
  }

  Future<Database> initBD() async {
    Directory documentsDirectory = await getApplicationCacheDirectory();
    final path = join(documentsDirectory.path, 'recipes.db');
    print(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $preperationTimeColumn INTEGER, $isFavoriteColumn INTEGER, $ingredientsColumn TEXT, $instructionsColumn TEXT, $imageColumn TEXT)');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        db.execute(
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $preperationTimeColumn INTEGER, $isFavoriteColumn INTEGER, $ingredientsColumn TEXT, $instructionsColumn TEXT, $imageColumn TEXT)');
      },
      onDowngrade: (db, oldVersion, newVersion) {
        db.delete(tableName);
      },
    );
  }

  Future<List<RecipeModel>> getAllRecipes() async {
    final db = await database;
    List<Map<String, dynamic>> tasks = await db!.query(tableName);
    return tasks.map((e) => RecipeModel.fromMap(e)).toList();
  }

  insertNewRecipe(RecipeModel recipeModel) async {
    final db = await database;
    final res = await db!.insert(tableName, recipeModel.toMap());
    return res;
  }

  deleteRecipe(RecipeModel recipeModel) async {
    final db = await database;
    final res = await db!
        .delete(tableName, where: '$idColumn=?', whereArgs: [recipeModel.id]);
    return res;
  }

  deleteRecipes() async {
    final db = await database;
    final res = await db!.delete(tableName);
    return res;
  }

  updateRecipe(RecipeModel recipeModel) async {
    final db = await database;
    final res = await db!.update(
        tableName,
        {
          isFavoriteColumn: recipeModel.isFavorite ? 1 : 0,
          nameColumn: recipeModel.name,
          preperationTimeColumn: recipeModel.preperationTime,
          imageColumn: recipeModel.image!.path,
          ingredientsColumn: recipeModel.ingredients,
          instructionsColumn: recipeModel.instructions
        },
        where: '$idColumn=?',
        whereArgs: [recipeModel.id]);
    return res;
  }

  updateIsFavorite(RecipeModel recipeModel) async {
    final db = await database;
    final res = await db!.update(
        tableName, {isFavoriteColumn: !recipeModel.isFavorite ? 1 : 0},
        where: '$idColumn=?', whereArgs: [recipeModel.id]);
    return res;
  }

/*
  initDatabase() async {
    database = await connectToDatabase();
  }

  Future<Database> connectToDatabase() async {
    Directory directory = await getApplicationCacheDirectory();
    String path = '$directory/recipes.db';
    print(path);
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $preperationTimeColumn INTEGER, $isFavoriteColumn INTEGER, $ingredientsColumn TEXT, $instructionsColumn TEXT, $imageColumn TEXT)');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        db.execute(
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $preperationTimeColumn INTEGER, $isFavoriteColumn INTEGER, $ingredientsColumn TEXT, $instructionsColumn TEXT, $imageColumn TEXT)');
      },
      onDowngrade: (db, oldVersion, newVersion) {
        db.delete(tableName);
      },
    );
  }*/
}
