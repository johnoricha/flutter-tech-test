import 'package:equatable/equatable.dart';
import 'package:tech_task/features/recipe/cubits/models/ingredient.dart';
import 'package:tech_task/features/recipe/cubits/models/recipe.dart';
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




