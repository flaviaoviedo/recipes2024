import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/data_repository/dbHelper.dart';

import "package:sqflite/sqflite.dart";

import 'package:recipes/providers/recipe_provider.dart';
import 'package:recipes/ui/screens/favorite_recipes_screen.dart';
import 'package:recipes/ui/screens/main_recipe_screen.dart';
import 'package:recipes/ui/screens/new_recipe_screen.dart';

import 'package:recipes/ui/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initBD();
  //await ItemDbHelper.dbHelper.initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //cargar bd en sqlite
    DbHelper.db.database;
    // final tempScan = new RecipeModel(
    //   name: 'jugo',
    //   isFavorite: true,
    //   preperationTime: 1,
    //   ingredients: 'lavado',
    //   instructions: 'lavado',
    // );
    // final res = DbHelper.db.insertNewRecipe(tempScan);
    // print(res);

    return (MultiProvider(
      providers: [
        ChangeNotifierProvider<RecipeClass>(
          create: (context) => RecipeClass(),
        ),
        // ChangeNotifierProvider<ItemClass>(
        //   create: (context) => ItemClass(),
        // ),
      ],
      child: InitApp(),
    ));
  }
}

class InitApp extends StatelessWidget {
  InitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<RecipeClass>(context).isDark
          ? ThemeData.dark()
          : ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.blue[200],
              dialogBackgroundColor: Colors.blue[200],
              primaryColor: Colors.blue[200],
            ),
      title: 'gsk',
      home: SplashScreen(),
      routes: {
        '/favorite_recipes_screen': (context) => const FavoriteRecipesScreen(),
        '/new_recipe_screen': (context) => const NewRecipeScreen(),
        '/main_recipe_screen': (context) => const MainRecipeScreen(),
        //'/shopping_list_screen': (context) => const ShoppingListScreen(),
      },
    );
  }
}
