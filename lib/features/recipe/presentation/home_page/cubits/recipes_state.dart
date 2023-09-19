import 'package:equatable/equatable.dart';
import 'package:tech_task/features/recipe/data/models/ingredient_model.dart';

class RecipesState extends Equatable {
  final List<Ingredient>? ingredients;

  RecipesState({this.ingredients});

  RecipesState copyWith({List<Ingredient>? ingredients}) =>
      RecipesState(ingredients: ingredients ?? this.ingredients);

  @override
  List<Object?> get props => [ingredients];
}

class Ingredient extends Equatable {
  final String title;
  final String useBy;
  final bool isChecked;

  const Ingredient(
      {required this.title, required this.useBy, this.isChecked = false});

  Ingredient copyWith(bool? isChecked) => Ingredient(
      title: title, useBy: useBy, isChecked: isChecked ?? this.isChecked);

  @override
  List<Object?> get props => [title, useBy, isChecked];
}
