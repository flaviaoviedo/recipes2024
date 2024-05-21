import 'package:flutter/material.dart';
import 'package:recipes/models/recipe_model.dart';
import 'package:recipes/ui/widgets/recipe_widget.dart';

class SearchRecipeScreen extends StatefulWidget {
  final List<RecipeModel> recipes;
  List<RecipeModel> filteredRecipes = [];

  SearchRecipeScreen({super.key, required this.recipes}) {
    filteredRecipes = recipes;
  }

  @override
  State<SearchRecipeScreen> createState() => _SearchRecipeScreenState();
}

class _SearchRecipeScreenState extends State<SearchRecipeScreen> {
  void filterRecipes(value) {
    setState(() {
      widget.filteredRecipes = widget.recipes
          .where((recipe) =>
              recipe.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            filterRecipes(value);
          },
          decoration: InputDecoration(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: "Search Recipe",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: widget.filteredRecipes.isNotEmpty
              ? ListView.builder(
                  itemCount: widget.filteredRecipes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RecipeWidget(widget.filteredRecipes[index]);
                  },
                )
              : Center(
                  child: Text('Recipe not found...'),
                )),
    );
  }
}
