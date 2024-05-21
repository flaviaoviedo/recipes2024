import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/models/recipe_model.dart';
import 'package:recipes/providers/recipe_provider.dart';
import 'package:recipes/ui/screens/show_recipe_screen.dart';

class RecipeWidget extends StatelessWidget {
  const RecipeWidget(this.recipeModel);
  final RecipeModel recipeModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShowRecipeScreen(
                      recipeModel: recipeModel,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          color: !Provider.of<RecipeClass>(context).isDark
              ? Colors.blue[100]
              : null,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        child: ListTile(
          tileColor: !Provider.of<RecipeClass>(context).isDark
              ? Colors.blue[100]
              : null,
          leading: recipeModel.image == null
              ? Container(
                  decoration: BoxDecoration(
                    color: !Provider.of<RecipeClass>(context).isDark
                        ? Colors.blue
                        : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: double.infinity,
                  width: 70,
                  child: Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/food_logo.png'),
                    ),
                  ),
                )
              : Image.file(
                  recipeModel.image!,
                  width: 70,
                  height: double.infinity,
                ),
          title: Text(recipeModel.name),
          subtitle: Text('${recipeModel.preperationTime} mins'),
          trailing: InkWell(
            onTap: () {
              Provider.of<RecipeClass>(context, listen: false)
                  .updateIsFavorite(recipeModel);
            },
            child: recipeModel.isFavorite
                ? Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
          ),
        ),
      ),
    );
  }
}
