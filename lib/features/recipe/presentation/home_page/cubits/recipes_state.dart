import 'package:equatable/equatable.dart';
import 'package:tech_task/features/recipe/data/models/ingredient_model.dart';
import 'package:tech_task/features/recipe/utils/state_status.dart';

class RecipesState extends Equatable {
  final List<Ingredient>? ingredients;
  final Set<Ingredient>? selectedIngredients;
  final StateStatus? getIngredientsStateStatus;

  RecipesState(
      {this.ingredients,
      this.selectedIngredients,
      this.getIngredientsStateStatus = StateStatus.initialState});

  RecipesState copyWith({
    List<Ingredient>? ingredients,
    Set<Ingredient>? selectedIngredients,
    StateStatus? getIngredientsStateStatus,
  }) =>
      RecipesState(
          ingredients: ingredients ?? this.ingredients,
          selectedIngredients: selectedIngredients ?? this.selectedIngredients,
          getIngredientsStateStatus:
              getIngredientsStateStatus ?? this.getIngredientsStateStatus);

  @override
  List<Object?> get props => [
        ingredients,
        selectedIngredients,
        getIngredientsStateStatus,
      ];
}

class Ingredient extends Equatable {
  final String title;
  final String useBy;
  final bool isChecked;
  // final bool isEnabled;

  const Ingredient(
      {required this.title,
      required this.useBy,
      this.isChecked = false,
      // this.isEnabled = true,
      });

  Ingredient copyWith({bool? isChecked, bool? isEnabled}) => Ingredient(
        title: title,
        useBy: useBy,
        isChecked: isChecked ?? this.isChecked,
        // isEnabled: isEnabled ?? this.isEnabled,
      );

  @override
  List<Object?> get props => [
        title,
        useBy,
        isChecked,
        // isEnabled,
      ];
}
