import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/recipe_provider.dart';

class NewRecipeScreen extends StatefulWidget {
  const NewRecipeScreen({super.key});

  @override
  State<NewRecipeScreen> createState() => _NewRecipeScreenState();
}

class _NewRecipeScreenState extends State<NewRecipeScreen> {
  Future pickImage(BuildContext context, ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    Provider.of<RecipeClass>(context, listen: false).image = File(image.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add New Recipe'),
        ),
        body: Consumer<RecipeClass>(
          builder: (context, provider, child) => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  TextField(
                    controller: provider.nameController,
                    decoration: InputDecoration(
                        label: Text('Recipe Name'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: provider.preperationTimeController,
                    decoration: InputDecoration(
                        label: Text('Preperation Time (mins)'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      PopupMenuButton(
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                    onTap: () =>
                                        pickImage(context, ImageSource.camera),
                                    child: Row(
                                      children: [
                                        Icon(Icons.camera_alt_outlined),
                                        SizedBox(width: 5),
                                        Text('Toma una foto')
                                      ],
                                    )),
                                PopupMenuItem(
                                    onTap: () =>
                                        pickImage(context, ImageSource.gallery),
                                    child: Row(
                                      children: [
                                        Icon(Icons.image_outlined),
                                        SizedBox(width: 5),
                                        Text('Select a picture'),
                                      ],
                                    ))
                              ]),
                      Text(
                        'ADD A PICTURE',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Visibility(
                      visible: provider.image != null,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              provider.image = null;
                              setState(() {});
                            },
                            child: Icon(
                              Icons.cancel_outlined,
                              color: Colors.red,
                            ),
                          ),
                          provider.image != null
                              ? Image.file(
                                  provider.image!,
                                  width: 100,
                                  height: 100,
                                )
                              : Container(),
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      height: 100,
                      child: TextField(
                        expands: true,
                        maxLines: null,
                        controller: provider.ingredientsController,
                        decoration: InputDecoration(
                            label: Text('Ingredients'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      height: 100,
                      child: TextField(
                        expands: true,
                        maxLines: null,
                        controller: provider.instructionsController,
                        decoration: InputDecoration(
                            label: Text('Instructions'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      provider.insertNewRecipe();
                      provider.nameController.clear();

                      provider.preperationTimeController.clear();
                      provider.instructionsController.clear();
                      provider.ingredientsController.clear();
                      provider.image = null;
                      Navigator.of(context).pop();
                    },
                    child: Center(
                      child: Text('Save Recipe'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
