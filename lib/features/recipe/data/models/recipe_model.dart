import 'package:json_annotation/json_annotation.dart';
import 'package:tech_task/features/recipe/cubits/models/recipe.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class RecipeModel {
  final String title;
  final List<String> ingredients;

  const RecipeModel({required this.title, required this.ingredients});

  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);


  Recipe toRecipe() => Recipe(title: title, ingredients: ingredients);
}
