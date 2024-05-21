import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/recipe_provider.dart';
import 'package:recipes/ui/screens/search_recipe_screen.dart';
import 'package:recipes/ui/widgets/recipe_widget.dart';

class FavoriteRecipesScreen extends StatefulWidget {
  const FavoriteRecipesScreen({super.key});

  @override
  State<FavoriteRecipesScreen> createState() => _FavoriteRecipesScreenState();
}

class _FavoriteRecipesScreenState extends State<FavoriteRecipesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>(
      builder: (BuildContext context, myProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My Recipes'),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Favorite Recipes:',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 244, 143, 177)),
                )
              ],
            ),
            actions: [
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      SearchRecipeScreen(recipes: myProvider.favoriteRecipes),
                )),
                child: Icon(Icons.search),
              ),
              PopupMenuButton(
                  color: Colors.blue[200],
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text('Open menu'),
                        ),
                        PopupMenuItem(
                          child: Text('About'),
                        ),
                        PopupMenuItem(
                          onTap: () => exit(0),
                          child: Column(
                            children: [
                              Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.exit_to_app_outlined,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Exit')
                                ],
                              )
                            ],
                          ),
                        ),
                      ]),
            ],
          ),
          drawer: Drawer(
            backgroundColor: Colors.blue[200],
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  color: !myProvider.isDark ? Colors.blue[200] : null,
                  child: Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/food_logo.png'),
                      radius: 50,
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Home'),
                  leading: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/main_recipe_screen');
                  },
                ),
                ListTile(
                  title: Text('Favorite Recipes'),
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/favorite_recipes_screen');
                  },
                ),
                Divider(
                  thickness: 1,
                ),
                ListTile(
                  title: Text('Shopping List'),
                  leading: Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  ),
                  onTap: () {},
                ),
                Divider(
                  thickness: 1,
                ),
              ],
            ),
          ),
          body: ListView.builder(
            itemCount: myProvider.favoriteRecipes.length,
            itemBuilder: (context, index) {
              return RecipeWidget(myProvider.favoriteRecipes[index]);
            },
          ),
        );
      },
    );
  }
}
