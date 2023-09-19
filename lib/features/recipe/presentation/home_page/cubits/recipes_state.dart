import 'package:equatable/equatable.dart';
import 'package:tech_task/features/recipe/data/models/ingredient.dart';

class RecipesState extends Equatable {
  final List<Ingredient>? ingredients;

  RecipesState({this.ingredients});

  RecipesState copyWith({List<Ingredient>? ingredients}) =>
      RecipesState(ingredients: ingredients ?? this.ingredients);

  @override
  List<Object?> get props => [ingredients];
}
