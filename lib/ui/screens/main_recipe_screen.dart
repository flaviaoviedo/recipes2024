import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/recipe_provider.dart';
import 'package:recipes/ui/screens/search_recipe_screen.dart';
import 'package:recipes/ui/widgets/recipe_widget.dart';

class MainRecipeScreen extends StatelessWidget {
  const MainRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>(
      builder: (BuildContext context, myProvider, Widget? child) => Scaffold(
        appBar: AppBar(
          title: Text('My Recipes'),
          actions: [
            InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      SearchRecipeScreen(recipes: myProvider.allRecipes))),
              child: Icon(Icons.search),
            ),
            PopupMenuButton(
                color: !myProvider.isDark ? Colors.blue[200] : null,
                itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: (() => Scaffold.of(context).openDrawer()),
                        child: Text('Open menu'),
                      ),
                      PopupMenuItem(
                        child: Text('About'),
                      ),
                      PopupMenuItem(
                          onTap: () => exit(0),
                          child: const Column(
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
                                    height: 10,
                                  ),
                                  Text('Exit'),
                                ],
                              )
                            ],
                          ))
                    ]),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (() async {
            await Navigator.pushNamed(context, '/new_recipe_screen');
            // ignore: use_build_context_synchronously
            Navigator.pushReplacementNamed(context, '/main_recipe_screen');
          }),
          child: Icon(Icons.add),
        ),
        drawer: Drawer(
          backgroundColor: !myProvider.isDark ? Colors.blue[200] : null,
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
                  Navigator.pushReplacementNamed(
                      context, '/main_recipe_screen');
                },
              ),
              ListTile(
                title: Text('Favorite Recipes'),
                leading: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, '/favorite_recipes_screen');
                },
              ),
              // Divider(
              //   thickness: 1,
              // ),
              // ListTile(
              //   title: Text('Shopping List'),
              //   leading: Icon(
              //     Icons.shopping_cart,
              //     color: Colors.black,
              //   ),
              //   onTap: () {
              //     Navigator.pushNamed(context, '/shopping_list_screen');
              //   },
              // ),
              // Divider(
              //   thickness: 1,
              // ),
              Provider.of<RecipeClass>(context).isDark
                  ? ListTile(
                      title: Text('Light Mode'),
                      leading: Icon(
                        Icons.light_mode_outlined,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Provider.of<RecipeClass>(context, listen: false)
                            .changeIsDark();
                        Navigator.pop(context);
                      },
                    )
                  : ListTile(
                      title: Text('Dark Mode'),
                      leading: Icon(
                        Icons.dark_mode_outlined,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Provider.of<RecipeClass>(context, listen: false)
                            .changeIsDark();
                        Navigator.pop(context);
                      },
                    )
            ],
          ),
        ),
        body: ListView.builder(
          itemCount: myProvider.allRecipes.length,
          itemBuilder: (context, index) {
            return RecipeWidget(myProvider.allRecipes[index]);
          },
        ),
      ),
    );
  }
}
