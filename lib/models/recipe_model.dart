import 'dart:io';

class RecipeModel {
  int? id;
  String name;
  bool isFavorite;
  File? image;
  int preperationTime;
  String ingredients;
  String instructions;

  RecipeModel({
    this.id,
    required this.name,
    required this.isFavorite,
    this.image,
    required this.preperationTime,
    required this.ingredients,
    required this.instructions,
  });

  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
        id: map['id'],
        name: map['name'],
        isFavorite: map['isFavorite'] == 1 ? true : false,
        preperationTime: map["preperationTime"],
        ingredients: map["ingredients"],
        instructions: map["instructions"],
        image: map["image"] != null ? File(map['image']) : null);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "isFavorite": isFavorite ? 1 : 0,
        "preperationTime": preperationTime,
        "ingredients": ingredients,
        "instructions": instructions,
        "image": image == null ? '' : image!.path,
      };
}
