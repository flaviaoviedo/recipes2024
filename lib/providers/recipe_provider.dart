import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipes/data_repository/dbHelper.dart';
import 'package:recipes/models/recipe_model.dart';
import 'package:recipes/ui/screens/favorite_recipes_screen.dart';

class RecipeClass extends ChangeNotifier {
  RecipeClass() {
    getRecipes();
  }
  bool isDark = false;
  changeIsDark() {
    isDark = !isDark;
    notifyListeners();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController preperationTimeController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  File? image;

  List<RecipeModel> allRecipes = [];
  List<RecipeModel> favoriteRecipes = [];
  getRecipes() async {
    allRecipes = await DbHelper.dbHelper.getAllRecipes();
    favoriteRecipes = allRecipes.where((e) => e.isFavorite).toList();
    notifyListeners();
  }

  insertNewRecipe() {
    RecipeModel recipeModel = RecipeModel(
      name: nameController.text,
      isFavorite: false,
      image: image,
      ingredients: ingredientsController.text,
      instructions: instructionsController.text,
      preperationTime: int.parse(preperationTimeController.text != ''
          ? preperationTimeController.text
          : '0'),
    );
    DbHelper.dbHelper.insertNewRecipe(recipeModel);
    getRecipes();
  }

  updateRecipe(RecipeModel recipeModel) async {
    await DbHelper.dbHelper.updateRecipe(recipeModel);
    getRecipes();
  }

  updateIsFavorite(RecipeModel recipeModel) async {
    await DbHelper.dbHelper.updateIsFavorite(recipeModel);
    getRecipes();
  }

  deleteRecipe(RecipeModel recipeModel) {
    DbHelper.dbHelper.deleteRecipe(recipeModel);
    getRecipes();
  }
}
