import 'package:equatable/equatable.dart';
import 'package:tech_task/features/recipe/utils/state_status.dart';

class RecipesState extends Equatable {
  final List<Ingredient>? ingredients;
  final Set<Ingredient> selectedIngredients;
  final List<Recipe> recipes;
  final StateStatus? getIngredientsStateStatus;
  final StateStatus? getRecipesStateStatus;

  RecipesState(
      {this.ingredients,
      this.recipes = const [],
      this.selectedIngredients = const {},
      this.getIngredientsStateStatus = StateStatus.initialState,
      this.getRecipesStateStatus = StateStatus.initialState,
      });

  RecipesState copyWith({
    List<Ingredient>? ingredients,
    Set<Ingredient>? selectedIngredients,
    List<Recipe>? recipes,
    StateStatus? getIngredientsStateStatus,
    StateStatus? getRecipesStateStatus,
  }) =>
      RecipesState(
          recipes: recipes ?? this.recipes,
          ingredients: ingredients ?? this.ingredients,
          selectedIngredients: selectedIngredients ?? this.selectedIngredients,
          getRecipesStateStatus: getRecipesStateStatus ?? this.getRecipesStateStatus,
          getIngredientsStateStatus:
              getIngredientsStateStatus ?? this.getIngredientsStateStatus);

  @override
  List<Object?> get props => [
        ingredients,
        recipes,
        selectedIngredients,
        getRecipesStateStatus,
        getIngredientsStateStatus,
      ];
}

class Ingredient extends Equatable {
  final String title;
  final String useBy;
  final bool isChecked;

  const Ingredient({
    required this.title,
    required this.useBy,
    this.isChecked = false,
  });

  Ingredient copyWith({bool? isChecked, bool? isEnabled}) => Ingredient(
        title: title,
        useBy: useBy,
        isChecked: isChecked ?? this.isChecked,
      );

  @override
  List<Object?> get props => [
        title,
        useBy,
        isChecked,
      ];
}

class Recipe extends Equatable {
  final String title;
  final List<String> ingredients;

  const Recipe({required this.title, required this.ingredients});

  @override
  List<Object?> get props => [title, ingredients];
}
